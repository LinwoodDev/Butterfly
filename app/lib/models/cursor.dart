import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

@immutable
class ToolCursorData<T> {
  final T tool;
  final Offset position;

  const ToolCursorData(this.tool, this.position);
}
