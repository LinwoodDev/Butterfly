import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

@immutable
class ToolCursorData<T extends Tool> {
  final T tool;
  final Offset position;

  const ToolCursorData(this.tool, this.position);
}
