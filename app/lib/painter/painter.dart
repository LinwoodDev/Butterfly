import 'package:flutter/cupertino.dart';

@immutable
abstract class Painter {
  final String name;
  const Painter({this.name = ''});
  Painter.fromJson(Map<String, dynamic> json, [String? fileVersion]) : name = json['name'] ?? "";
  Map<String, dynamic> toJson() => {"name": name};
}
