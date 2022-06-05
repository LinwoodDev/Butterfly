part of '../renderer.dart';

class LabelRenderer extends Renderer<LabelElement> {
  @override
  Rect rect;

  LabelRenderer(super.element, [this.rect = Rect.zero]);

  TextAlign _convertAlignment(HorizontalAlignment alignment) {
    switch (alignment) {
      case HorizontalAlignment.left:
        return TextAlign.left;
      case HorizontalAlignment.right:
        return TextAlign.right;
      case HorizontalAlignment.center:
        return TextAlign.center;
      case HorizontalAlignment.justify:
        return TextAlign.justify;
    }
  }

  TextPainter _createPainter() => TextPainter(
      text: TextSpan(
          style: TextStyle(
              fontSize: element.property.size,
              fontFamily: 'Roboto',
              fontStyle:
                  element.property.italic ? FontStyle.italic : FontStyle.normal,
              color: Color(element.property.color),
              fontWeight: FontWeight.values[element.property.fontWeight],
              letterSpacing: element.property.letterSpacing,
              decorationColor: Color(element.property.decorationColor),
              decorationStyle: element.property.decorationStyle,
              decorationThickness: element.property.decorationThickness,
              decoration: TextDecoration.combine([
                if (element.property.underline) TextDecoration.underline,
                if (element.property.lineThrough) TextDecoration.lineThrough,
                if (element.property.overline) TextDecoration.overline,
              ])),
          text: element.text),
      textAlign: _convertAlignment(element.property.horizontalAlignment),
      textDirection: TextDirection.ltr,
      textScaleFactor: 1.0);

  @override
  FutureOr<void> setup(AppDocument document) async {
    _updateRect();
    await super.setup(document);
    _updateRect();
  }

  @override
  FutureOr<bool> onAreaUpdate(AppDocument document, Area? area) async {
    await super.onAreaUpdate(document, area);
    _updateRect();
    return true;
  }

  void _updateRect() {
    var maxWidth = double.infinity;
    final constraints = element.constraint;
    if (constraints.size > 0) maxWidth = constraints.size;
    if (constraints.includeArea && area != null) {
      maxWidth = min(maxWidth + element.position.dx, area!.rect.right) -
          element.position.dx;
    }
    final tp = _createPainter();
    tp.layout(maxWidth: maxWidth);
    var height = tp.height;
    if (height < constraints.length) {
      height = constraints.length;
    } else if (constraints.includeArea && area != null) {
      height = max(height, area!.rect.bottom - element.position.dy);
    }
    rect = Rect.fromLTWH(
        element.position.dx, element.position.dy, tp.width, height);
  }

  @override
  FutureOr<void> build(Canvas canvas, Size size, CameraTransform transform,
      [bool foreground = false]) {
    final tp = _createPainter();
    tp.layout(maxWidth: rect.width);
    var current = element.position;
    // Change vertical alignment
    final align = element.property.verticalAlignment;
    switch (align) {
      case VerticalAlignment.top:
        current = current.translate(0, 0);
        break;
      case VerticalAlignment.bottom:
        current = current.translate(0, rect.height - tp.height);
        break;
      case VerticalAlignment.center:
        current = current.translate(0, (rect.height - tp.height) / 2);
        break;
    }
    tp.paint(canvas, current);
  }

  @override
  void buildSVG(XmlDocument xml, AppDocument document, Rect rect) {
    if (!this.rect.overlaps(rect)) return;
    final property = element.property;
    String textDecoration = '';
    if (property.underline) textDecoration += 'underline ';
    if (property.lineThrough) textDecoration += 'line-through ';
    if (property.overline) textDecoration += 'overline ';
    textDecoration +=
        '${property.decorationStyle.name} ${property.decorationThickness}px ${property.decorationColor.toRadixString(16).substring(2)}';
    final foreignObject =
        xml.getElement('svg')?.createElement('foreignObject', attributes: {
      'x': '${this.rect.left}px',
      'y': '${this.rect.top}px',
      'width': '${this.rect.width}px',
      'height': '${min(this.rect.height, rect.bottom)}px',
    });
    String alignItems = 'center';
    switch (element.property.verticalAlignment) {
      case VerticalAlignment.top:
        alignItems = 'flex-start';
        break;
      case VerticalAlignment.bottom:
        alignItems = 'flex-end';
        break;
      case VerticalAlignment.center:
        alignItems = 'center';
        break;
    }
    String alignContent = 'center';
    switch (element.property.horizontalAlignment) {
      case HorizontalAlignment.left:
        alignContent = 'flex-start';
        break;
      case HorizontalAlignment.right:
        alignContent = 'flex-end';
        break;
      case HorizontalAlignment.center:
        alignContent = 'center';
        break;
      case HorizontalAlignment.justify:
        alignContent = 'space-between';
        break;
    }
    final div = foreignObject?.createElement('div', attributes: {
      'style': 'font-size: ${property.size}px;'
          'font-style: ${property.italic ? 'italic' : 'normal'};'
          'font-weight: ${property.fontWeight};'
          'font-family: Roboto;'
          'letter-spacing: ${property.letterSpacing}px;'
          'color: #${property.color.toRadixString(16).substring(2)};'
          'text-decoration: $textDecoration;'
          'display: flex;'
          'align-items: $alignItems;'
          'justify-content: $alignContent;'
          'height: ${this.rect.height}px;'
          'width: ${this.rect.width}px;',
      'xmlns': 'http://www.w3.org/1999/xhtml',
    });
    div?.innerText = element.text;
  }

  @override
  LabelElement move(Offset position) => element.copyWith(position: position);
}
