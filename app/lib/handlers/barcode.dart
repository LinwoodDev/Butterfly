part of 'handler.dart';

class BarcodeHandler extends PastingHandler<BarcodeTool>
    with ColoredHandler<BarcodeTool> {
  SvgElement? _element;

  BarcodeHandler(super.data);

  @override
  SelectState onSelected(BuildContext context, [bool wasAdded = true]) {
    showDialog<String>(context: context, builder: (context) => NameDialog())
        .then((value) {
      if (value == null) return;
      final barcode = switch (data.barcodeType) {
        BarcodeType.dataMatrix => Barcode.dataMatrix(),
        BarcodeType.qrCode => Barcode.qrCode(),
      };
      final svg = barcode.toSvg(value,
          width: 500, height: 500, color: data.color.value);
      _element = SvgElement(
          source: Uri.dataFromString(svg, mimeType: 'image/svg+xml').toString(),
          width: 500,
          height: 500);
    });
    return SelectState.normal;
  }

  @override
  SRGBColor getColor() => data.color;

  @override
  BarcodeTool setColor(SRGBColor color) => data.copyWith(color: color);

  @override
  List<PadElement> transformElements(
      Rect rect, String collection, CurrentIndexCubit cubit) {
    final element = _element;
    if (element == null) return [];
    if (rect.isEmpty) return [];

    return [
      element.copyWith(
        position: rect.topLeft.toPoint(),
        width: rect.width,
        height: rect.height,
      ),
    ];
  }
}
