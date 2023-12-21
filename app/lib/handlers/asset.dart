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

  Future<void> importWithDialog(AssetFileType type) async {
    final (result, _) = await importFile(context, [type]);
    if (result == null) return;
    return importAsset(type, result);
  }

  if (!type.isAvailable()) return;

  switch (type) {
    case ImportType.image:
      return importWithDialog(AssetFileType.image);
    case ImportType.camera:
      final content = await showDialog<Uint8List>(
        context: context,
        builder: (context) => const CameraDialog(),
      );
      if (content == null) return;
      return importAsset(AssetFileType.image, content);
    case ImportType.svg:
      return importWithDialog(AssetFileType.svg);
    case ImportType.pdf:
      return importWithDialog(AssetFileType.pdf);
    case ImportType.document:
      return importWithDialog(AssetFileType.note);
    case ImportType.markdown:
      return importWithDialog(AssetFileType.markdown);
    case ImportType.xopp:
      return importWithDialog(AssetFileType.xopp);
  }
}
