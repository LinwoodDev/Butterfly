import 'package:flutter/material.dart';

part 'pen.dart';
part 'path.dart';
part 'label.dart';
part 'hand.dart';

abstract class Property {
  const Property();
  Property.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
  Property copyWith();
}
