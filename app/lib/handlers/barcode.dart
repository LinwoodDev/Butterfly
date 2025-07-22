part of 'handler.dart';

class BarcodeHandler extends PastingHandler<BarcodeTool>
    with ColoredHandler<BarcodeTool> {
  SvgElement? _element;

  BarcodeHandler(super.data);

  @override
  SelectState onSelected(BuildContext context, [bool wasAdded = true]) {
    final loc = AppLocalizations.of(context);
    showDialog<String>(
      context: context,
      builder: (context) => NameDialog(title: loc.enterText, hint: loc.text),
    ).then((value) {
      if (value == null) return;
      final barcode = switch (data.barcodeType) {
        BarcodeType.dataMatrix => Barcode.dataMatrix(),
        BarcodeType.qrCode => Barcode.qrCode(),
        BarcodeType.code128 => Barcode.code128(),
      };
      final width = data.barcodeType.width;
      final height = data.barcodeType.height;
      final svg = barcode.toSvg(
        value,
        width: width,
        height: height,
        color: data.color.value,
      );
      _element = SvgElement(
        source: Uri.dataFromString(svg, mimeType: 'image/svg+xml').toString(),
        width: width,
        height: height,
      );
    });
    return SelectState.normal;
  }

  @override
  SRGBColor getColor() => data.color;

  @override
  BarcodeTool setColor(SRGBColor color) => data.copyWith(color: color);

  @override
  List<PadElement> transformElements(
    Rect rect,
    String collection,
    CurrentIndexCubit cubit,
  ) {
    final element = _element;
    if (element == null) return [];
    if (rect.isEmpty) {
      return [
        element.copyWith(
          position:
              rect.topLeft.toPoint() -
              Point(element.width / 2, element.height / 2),
        ),
      ];
    }

    return [
      element.copyWith(
        position: rect.topLeft.toPoint(),
        width: rect.width,
        height: rect.height,
      ),
    ];
  }

  @override
  double get constraintedAspectRatio =>
      (_element?.width ?? 1) / (_element?.height ?? 1);

  @override
  ToolStatus getStatus(DocumentBloc bloc) =>
      _element == null ? ToolStatus.normal : ToolStatus.selected;
}
