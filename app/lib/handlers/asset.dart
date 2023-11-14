part of 'handler.dart';

class AssetHandler extends Handler<AssetTool> {
  AssetHandler(super.data);

  @override
  void onTapUp(TapUpDetails details, EventContext context) {
    final globalPos =
        context.getCameraTransform().localToGlobal(details.localPosition);
    showImportAssetWizard(
      data.importType,
      context.buildContext,
      context.getDocumentBloc(),
      context.getImportService(),
      position: globalPos,
      advanced: data.advanced,
    );
  }
}

Future<void> showImportAssetWizard(ImportType type, BuildContext context,
    DocumentBloc bloc, ImportService service,
    {Offset? position, bool advanced = true}) async {
  Future<void> importAsset(AssetFileType type, Uint8List bytes) async {
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    await service.import(type, bytes, state.data,
        position: position, advanced: advanced);
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
    return importAsset(assetType, content);
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
      return importAsset(AssetFileType.image, content);
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
      return importAsset(AssetFileType.note, data);
    case ImportType.markdown:
      return importWithDialog(
        AssetFileType.markdown,
        type: FileType.custom,
        allowedExtensions: ['md', 'markdown'],
      );
  }
}
