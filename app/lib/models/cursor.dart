import 'package:butterfly/models/painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

@immutable
class PainterCursor<T extends Painter> {
  final T painter;
  final Offset position;

  const PainterCursor(this.painter, this.position);
}
