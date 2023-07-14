part of 'handler.dart';

class AssetHandler extends Handler<AssetPainter> {
  AssetHandler(super.data);

  @override
  void onTapUp(TapUpDetails details, EventContext context) {
    final globalPos =
        context.getCameraTransform().localToGlobal(details.localPosition);
    showImportAssetWizard(data.importType, context.buildContext, globalPos);
  }
}

Future<void> showImportAssetWizard(ImportType type, BuildContext context,
    [Offset? position]) async {
  void importAsset(AssetFileType type, Uint8List bytes) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    context
        .read<ImportService>()
        .import(type, bytes, state.data, position: position);
  }

  if (!type.isAvailable()) return;

  switch (type) {
    case ImportType.image:
      final files = await FilePicker.platform.pickFiles(
          type: FileType.image, allowMultiple: false, withData: true);
      if (files?.files.isEmpty ?? true) return;
      final e = files!.files.first;
      var content = e.bytes ?? Uint8List(0);
      if (!kIsWeb) {
        content = await File(e.path ?? '').readAsBytes();
      }
      importAsset(AssetFileType.image, content);
      break;
    case ImportType.camera:
      final content = await showDialog<Uint8List>(
        context: context,
        builder: (context) => const CameraDialog(),
      );
      if (content == null) return;
      importAsset(AssetFileType.image, content);
      break;
    case ImportType.svg:
      final files = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['svg'],
          allowMultiple: false,
          withData: true);
      if (files?.files.isEmpty ?? true) return;
      final e = files!.files.first;
      var content = e.bytes ?? Uint8List(0);
      if (!kIsWeb) {
        content = await File(e.path ?? '').readAsBytes();
      }
      importAsset(AssetFileType.svg, content);
      break;
    case ImportType.pdf:
      final files = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
          allowMultiple: false,
          withData: true);
      if (files?.files.isEmpty ?? true) return;
      final e = files!.files.first;
      var content = e.bytes ?? Uint8List(0);
      if (!kIsWeb) {
        content = await File(e.path ?? '').readAsBytes();
      }
      importAsset(AssetFileType.pdf, content);
      break;
    case ImportType.document:
      final data = await openBfly();
      if (data == null) return;
      importAsset(AssetFileType.note, data);
      break;
  }
}
