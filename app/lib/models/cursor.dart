import 'package:butterfly/models/painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

@immutable
class PainterCursorData<T extends Painter> {
  final T painter;
  final Offset position;

  const PainterCursorData(this.painter, this.position);
}
