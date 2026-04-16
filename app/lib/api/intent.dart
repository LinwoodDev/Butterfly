import 'dart:async';
import 'dart:typed_data';
import 'package:butterfly/main.dart';
import 'package:flutter/services.dart';

(Uint8List, String)? _nativeData;

void setNativeData(Uint8List? data, [String? type]) {
  if (data != null) {
    _nativeData = (data, type ?? '');
  } else {
    _nativeData = null;
  }
}

String getNativeType() {
  return _nativeData?.$2 ?? '';
}

Uint8List? getNativeData() {
  return _nativeData?.$1;
}

Future<String?> getIntentType() async {
  final String? result = await platform.invokeMethod('getIntentType');
  return result;
}

Future<Uint8List?> getIntentData() async {
  final Uint8List? result = await platform.invokeMethod('getIntentData');
  return result;
}

Future<String?> getIntentUri() async {
  final String? result = await platform.invokeMethod('getIntentUri');
  return result;
}

Future<bool> writeContentUriData(String uri, Uint8List data) async {
  final bool? result = await platform.invokeMethod('writeContentUriData', {
    'uri': uri,
    'data': data,
  });
  return result ?? false;
}
