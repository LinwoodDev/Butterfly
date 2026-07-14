import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/save.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/defaults.dart';
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

const newShortcut = ShortcutDefinition(
  id: 'new',
  intent: NewIntent(fromTemplate: false),
  defaultActivator: SingleActivator(LogicalKeyboardKey.keyN, control: true),
);

const newFromTemplateShortcut = ShortcutDefinition(
  id: 'new_from_template',
  intent: NewIntent(fromTemplate: true),
  defaultActivator: SingleActivator(
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
    await openNewDocument(context, true, template);
  }
}

Future<void> openNewDocument(
  BuildContext context,
  bool replace, [
  NoteData? template,
  String? remote,
  Area? initialArea,
]) async {
  NoteData? document;
  String? path;
  var targetRemote = remote;
  if (template != null) {
    final settings = context.read<SettingsCubit>().state;
    final templatePattern = template.getMetadata()?.fileName.trim() ?? '';
    final fileNamePattern = templatePattern.isNotEmpty
        ? templatePattern
        : settings.defaultFileName.trim();
    var documentName = '';
    if (fileNamePattern.isNotEmpty) {
      try {
        documentName = resolveTemplateFileName(fileNamePattern, DateTime.now());
      } on FormatException {
        // Invalid patterns from imported templates should still open unsaved.
      }
    }
    document = template.createDocument(name: documentName);
    if (initialArea != null) {
      final page = document.getPage() ?? DocumentDefaults.createPage();
      document = document
          .setPage(page.copyWith(areas: [...page.areas, initialArea]))
          .$1;
    }
    final metadata = document.getMetadata();
    if (metadata != null) {
      path = metadata.directory;
      if (fileNamePattern.isNotEmpty && metadata.name.isNotEmpty) {
        final storage = settings.getRemote(targetRemote);
        final fileSystem = context
            .read<ButterflyFileSystem>()
            .buildDocumentSystem(storage);
        final created = await fileSystem.createFileWithName(
          directory: path,
          name: metadata.name,
          suffix: '.bfly',
          document.toFile(),
        );
        path = created.path;
        targetRemote = created.remote;
      }
    }
  }
  if (!context.mounted) return;
  final queryParams = <String, String>{'path': ?path, 'remote': ?targetRemote};
  if (replace) {
    GoRouter.of(
      context,
    ).goNamed('new', queryParameters: queryParams, extra: document);
    return;
  } else {
    await GoRouter.of(
      context,
    ).pushNamed('new', queryParameters: queryParams, extra: document);
  }
}
