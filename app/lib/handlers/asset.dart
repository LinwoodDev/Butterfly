part of 'handler.dart';

class AssetHandler extends Handler<AssetTool> {
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

  Future<void> importWithDialog(
    AssetFileType assetType, {
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  }) async {
    final files = await FilePicker.platform.pickFiles(
      type: type,
      allowedExtensions: allowedExtensions,
      allowMultiple: false,
      withData: true,
    );
    if (files?.files.isEmpty ?? true) return;
    final e = files!.files.first;
    var content = e.bytes ?? Uint8List(0);
    if (!kIsWeb) {
      content = await File(e.path ?? '').readAsBytes();
    }
    importAsset(assetType, content);
  }

  if (!type.isAvailable()) return;

  switch (type) {
    case ImportType.image:
      return importWithDialog(
        AssetFileType.image,
        type: FileType.image,
      );
    case ImportType.camera:
      final content = await showDialog<Uint8List>(
        context: context,
        builder: (context) => const CameraDialog(),
      );
      if (content == null) return;
      importAsset(AssetFileType.image, content);
      break;
    case ImportType.svg:
      return importWithDialog(
        AssetFileType.svg,
        type: FileType.custom,
        allowedExtensions: ['svg'],
      );
    case ImportType.pdf:
      return importWithDialog(
        AssetFileType.pdf,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
    case ImportType.document:
      final data = await openBfly();
      if (data == null) return;
      importAsset(AssetFileType.note, data);
      break;
    case ImportType.markdown:
      return importWithDialog(
        AssetFileType.markdown,
        type: FileType.custom,
        allowedExtensions: ['md', 'markdown'],
      );
  }
}
