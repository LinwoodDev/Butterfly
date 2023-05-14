import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubits/current_index.dart';
import '../dialogs/template.dart';
import '../models/defaults.dart';

class NewIntent extends Intent {
  final BuildContext context;
  final bool fromTemplate;

  const NewIntent(this.context, {this.fromTemplate = false});
}

class NewAction extends Action<NewIntent> {
  NewAction();

  @override
  Future<void> invoke(NewIntent intent) async {
    final context = intent.context;
    final bloc = context.read<DocumentBloc>();
    final settingsCubit = context.read<SettingsCubit>();
    final settings = settingsCubit.state;
    final transformCubit = context.read<TransformCubit>();
    final currentIndexCubit = context.read<CurrentIndexCubit>();
    final router = GoRouter.of(context);
    var path = '';
    var document = DocumentDefaults.createDocument();
    final prefs = await SharedPreferences.getInstance();
    final remote = settings.getDefaultRemote();
    if (intent.fromTemplate && context.mounted) {
      var state = bloc.state;
      if (state is DocumentLoadSuccess) document = state.data;
      var template = await showDialog<NoteData>(
          context: context,
          builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: bloc),
                  BlocProvider.value(value: transformCubit),
                  BlocProvider.value(value: currentIndexCubit),
                ],
                child: TemplateDialog(
                  currentDocument: document,
                ),
              ));
      if (template == null) return;
      document = template;
      final metadata = template.getMetadata();
      if (metadata != null) {
        template.setMetadata(metadata.copyWith(
          createdAt: DateTime.now().toUtc(),
        ));
        path = metadata.directory;
      }
    } else if (prefs.containsKey('default_template')) {
      var template = await TemplateFileSystem.fromPlatform(remote: remote)
          .getTemplate(prefs.getString('default_template')!);
      if (template != null) {
        final metadata = template.getMetadata();
        if (metadata != null) {
          template.setMetadata(metadata.copyWith(
            createdAt: DateTime.now().toUtc(),
          ));
          path = metadata.directory;
        }
      }
    }
    router.pushReplacementNamed('new',
        queryParameters: {'path': path}, extra: document);
  }
}
