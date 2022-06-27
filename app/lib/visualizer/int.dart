import 'package:flutter/material.dart';

extension IntVisualizer on int {
  String toHexColor({bool leadingHash = true}) {
    final color = Color(this);
    var hex = '';
    if (leadingHash) {
      hex += '#';
    }
    hex += color.red.toRadixString(16).padLeft(2, '0');
    hex += color.green.toRadixString(16).padLeft(2, '0');
    hex += color.blue.toRadixString(16).padLeft(2, '0');
    hex += color.alpha.toRadixString(16).padLeft(2, '0');
    return hex;
  }
}
