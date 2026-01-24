import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keybinder/keybinder.dart';

import '../dialogs/template.dart';

class NewIntent extends Intent {
  final bool fromTemplate;

  const NewIntent({this.fromTemplate = false});
}

final newShortcut = ShortcutDefinition(
  id: 'new',
  intent: const NewIntent(fromTemplate: false),
  defaultActivator: const SingleActivator(
    LogicalKeyboardKey.keyN,
    control: true,
  ),
);

final newFromTemplateShortcut = ShortcutDefinition(
  id: 'new_from_template',
  intent: const NewIntent(fromTemplate: true),
  defaultActivator: const SingleActivator(
    LogicalKeyboardKey.keyN,
    control: true,
    shift: true,
  ),
);

class NewAction extends Action<NewIntent> {
  final BuildContext context;

  NewAction(this.context);

  @override
  Future<void> invoke(NewIntent intent) async {
    final bloc = context.read<DocumentBloc>();
    final settingsCubit = context.read<SettingsCubit>();
    final settings = settingsCubit.state;
    if (intent.fromTemplate && context.mounted) {
      await showDialog(
        context: context,
        builder: (context) => TemplateDialog(bloc: bloc),
      );
      return;
    }
    final templateSystem = context
        .read<ButterflyFileSystem>()
        .buildDefaultTemplateSystem();
    final template = await templateSystem.getDefaultFile(
      templateSystem.storage?.defaults['template'] ?? settings.defaultTemplate,
    );
    openNewDocument(context, true, template);
  }
}

Future<void> openNewDocument(
  BuildContext context,
  bool replace, [
  NoteData? template,
  String? remote,
]) {
  NoteData? document;
  String? path;
  if (template != null) {
    document = template.createDocument();
    final metadata = document.getMetadata();
    if (metadata != null) {
      path = metadata.directory;
    }
  }
  final queryParams = <String, String>{
    if (path != null) 'path': path,
    if (remote != null) 'remote': remote,
  };
  if (replace) {
    return GoRouter.of(context).pushReplacementNamed(
      'new',
      queryParameters: queryParams,
      extra: document,
    );
  } else {
    return GoRouter.of(
      context,
    ).pushNamed('new', queryParameters: queryParams, extra: document);
  }
}
