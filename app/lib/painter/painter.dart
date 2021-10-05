import 'package:flutter/cupertino.dart';

@immutable
abstract class Painter {
  const Painter();
  const Painter.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
