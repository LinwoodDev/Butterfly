import 'dart:convert';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/import.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/current_index.dart';
import '../cubits/settings.dart';
import '../models/converter.dart';
import '../models/document.dart';
import '../renderers/renderer.dart';

class ImportIntent extends Intent {
  final BuildContext context;

  const ImportIntent(this.context);
}

class ImportAction extends Action<ImportIntent> {
  ImportAction();

  @override
  Future<void> invoke(ImportIntent intent) async {
    final bloc = intent.context.read<DocumentBloc>();
    final settingsCubit = intent.context.read<SettingsCubit>();
    final currentIndexCubit = intent.context.read<CurrentIndexCubit>();
    showDialog(
            builder: (context) => const ImportDialog(), context: intent.context)
        .then((content) {
      if (content == null) return;
      var document =
          const DocumentJsonConverter().fromJson(Map.from(jsonDecode(content)));
      DocumentFileSystem.fromPlatform(
              remote: settingsCubit.state.getDefaultRemote())
          .importDocument(document)
          .then((file) async {
        final background = Renderer.fromInstance(document.background);
        await background.setup(document);
        final renderers =
            document.content.map((e) => Renderer.fromInstance(e)).toList();
        await Future.wait(renderers.map((e) async => await e.setup(document)));
        bloc.emit(DocumentLoadSuccess(document,
            location: AssetLocation.local(file.path),
            currentIndexCubit: currentIndexCubit,
            settingsCubit: settingsCubit,
            cameraViewport: CameraViewport.unbaked(background, renderers)));
      });
    });
  }
}
