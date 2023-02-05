import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/format_date_time.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubits/current_index.dart';
import '../dialogs/template.dart';

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
    var document = AppDocument(
        name: await formatCurrentDateTime(
            context.read<SettingsCubit>().state.locale),
        createdAt: DateTime.now(),
        painters: createDefaultPainters(),
        palettes: DocumentDefaults.getMaterialPalette(context));
    final prefs = await SharedPreferences.getInstance();
    final remote = settings.getDefaultRemote();
    if (intent.fromTemplate && context.mounted) {
      var state = bloc.state;
      if (state is DocumentLoadSuccess) document = state.document;
      var template = await showDialog<DocumentTemplate>(
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
      document = template.document.copyWith(
        name: await formatCurrentDateTime(settings.locale),
        createdAt: DateTime.now(),
      );
    } else if (prefs.containsKey('default_template')) {
      var template = await TemplateFileSystem.fromPlatform(remote: remote)
          .getTemplate(prefs.getString('default_template')!);
      if (template != null) {
        document = template.document.copyWith(
          name: await formatCurrentDateTime(settings.locale),
          createdAt: DateTime.now(),
        );
      }
    }

    bloc.clearHistory();
    transformCubit.reset();
    currentIndexCubit.reset(document);
    final state = DocumentLoadSuccess(
      document,
      currentIndexCubit: currentIndexCubit,
      location: remote == null
          ? AssetLocation.local('')
          : AssetLocation(remote: remote.identifier, path: ''),
      settingsCubit: settingsCubit,
    );
    bloc.emit(state);
    await bloc.load();
  }
}
