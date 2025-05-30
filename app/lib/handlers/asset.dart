part of 'handler.dart';

class AssetHandler extends Handler<AssetTool> {
  AssetHandler(super.data);

  @override
  void onTapUp(TapUpDetails details, EventContext context) {
    final globalPos = context.getCameraTransform().localToGlobal(
      details.localPosition,
    );
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

Future<void> showImportAssetWizard(
  ImportType type,
  BuildContext context,
  DocumentBloc bloc,
  ImportService service, {
  Offset? position,
  bool advanced = true,
}) async {
  Future<void> importAsset(AssetFileType type, Uint8List bytes) async {
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    await service.import(
      type,
      bytes,
      document: state.data,
      position: position,
      advanced: advanced,
    );
  }

  Future<void> importWithDialog(List<AssetFileType> type) async {
    final (result, fileExtension) = await importFile(context, type);
    if (result == null) return;
    return importAsset(
      AssetFileTypeHelper.fromFileExtension(fileExtension) ??
          AssetFileType.note,
      result,
    );
  }

  if (!await type.isAvailable()) return;

  switch (type) {
    case ImportType.image:
      return importWithDialog([AssetFileType.image]);
    case ImportType.camera:
      final content = await showDialog<Uint8List>(
        context: context,
        builder: (context) => const CameraDialog(),
      );
      if (content == null) return;
      return importAsset(AssetFileType.image, content);
    case ImportType.svg:
      return importWithDialog([AssetFileType.svg]);
    case ImportType.svgText:
      final controller = TextEditingController();
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context).import),
          scrollable: true,
          content: TextField(
            maxLines: null,
            minLines: 3,
            controller: controller,
            autocorrect: false,
            autofocus: true,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).svgText,
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(PhosphorIconsLight.clipboard),
                onPressed: () async {
                  final clipboard = await Clipboard.getData(
                    Clipboard.kTextPlain,
                  );
                  final data = clipboard?.text;
                  if (data != null) controller.text = data;
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(AppLocalizations.of(context).import),
            ),
          ],
        ),
      );
      if (result != true) return;
      return importAsset(AssetFileType.svg, utf8.encode(controller.text));
    case ImportType.pdf:
      return importWithDialog([AssetFileType.pdf]);
    case ImportType.document:
      return importWithDialog([AssetFileType.note, AssetFileType.textNote]);
    case ImportType.markdown:
      return importWithDialog([AssetFileType.markdown]);
    case ImportType.xopp:
      return importWithDialog([AssetFileType.xopp]);
  }
}
