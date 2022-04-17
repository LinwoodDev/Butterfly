import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xml/xml.dart';

import '../api/format_date_time.dart';
import '../cubits/settings.dart';
import '../dialogs/svg_import.dart';
import '../models/viewport.dart';
import '../renderers/renderer.dart';

class SvgImportIntent extends Intent {
  final BuildContext context;

  const SvgImportIntent(this.context);
}

class SvgImportAction extends Action<SvgImportIntent> {
  SvgImportAction();

  @override
  Future<void> invoke(SvgImportIntent intent) async {
    var bloc = intent.context.read<DocumentBloc>();
    showDialog(
            builder: (context) => const SvgImportDialog(),
            context: intent.context)
        .then((content) async {
      if (content == null) return;
      var document = AppDocument.fromSvg(
          await formatCurrentDateTime(
              intent.context.read<SettingsCubit>().state.locale),
          XmlDocument.parse(content).rootElement);
      await DocumentFileSystem.fromPlatform()
          .importDocument(document)
          .then((file) async {
        final background = Renderer.fromInstance(document.background);
        await background.setup(document);
        final renderers =
            document.content.map((e) => Renderer.fromInstance(e)).toList();
        await Future.wait(renderers.map((e) async => await e.setup(document)));
        bloc.emit(DocumentLoadSuccess(document,
            path: file.path,
            cameraViewport: CameraViewport.unbaked(background, renderers)));
      });
    });
  }
}
