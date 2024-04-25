import 'dart:async';
import 'package:butterfly/main.dart';
import 'package:flutter/services.dart';

Future<String?> getIntentType() async {
  final String? result = await platform.invokeMethod('getIntentType');
  return result;
}

Future<Uint8List?> getIntentData() async {
  final Uint8List? result = await platform.invokeMethod('getIntentData');
  return result;
}
