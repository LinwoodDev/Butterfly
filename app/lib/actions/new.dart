import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/format_date_time.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editing.dart';
import 'package:butterfly/cubits/selection.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:butterfly/models/template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var document = AppDocument(
        name: await formatCurrentDateTime(
            intent.context.read<SettingsCubit>().state.locale),
        createdAt: DateTime.now(),
        palettes: ColorPalette.getMaterialPalette(intent.context));
    var bloc = intent.context.read<DocumentBloc>();
    var prefs = await SharedPreferences.getInstance();
    if (intent.fromTemplate) {
      var state = bloc.state;
      if (state is DocumentLoadSuccess) document = state.document;
      var template = await showDialog(
          context: intent.context,
          builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: bloc),
                  BlocProvider.value(
                      value: intent.context.read<SelectionCubit>()),
                  BlocProvider.value(
                      value: intent.context.read<EditingCubit>()),
                  BlocProvider.value(
                      value: intent.context.read<TransformCubit>()),
                ],
                child: TemplateDialog(
                  currentDocument: document,
                ),
              )) as DocumentTemplate?;
      if (template == null) return;
      document = template.document.copyWith(
        name: await formatCurrentDateTime(
            intent.context.read<SettingsCubit>().state.locale),
        createdAt: DateTime.now(),
      );
    } else if (prefs.containsKey('default_template')) {
      var template = await TemplateFileSystem.fromPlatform()
          .getTemplate(prefs.getString('default_template')!);
      if (template != null) {
        document = template.document.copyWith(
          name: await formatCurrentDateTime(
              intent.context.read<SettingsCubit>().state.locale),
          createdAt: DateTime.now(),
        );
      }
    }

    bloc.clearHistory();
    intent.context.read<SelectionCubit>().reset();
    intent.context.read<EditingCubit>().resetAll();
    intent.context.read<TransformCubit>().reset();
    bloc.emit(DocumentLoadSuccess(document));
  }
}
