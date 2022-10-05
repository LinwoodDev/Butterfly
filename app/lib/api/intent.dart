import 'dart:async';
import 'package:flutter/services.dart';

const platform = MethodChannel('linwood.dev/butterfly');

Future<String?> getIntentType() async {
  final String? result = await platform.invokeMethod('getIntentType');
  return result;
}

Future<String?> getIntentData() async {
  final String? result = await platform.invokeMethod('getIntentData');
  return result;
}
