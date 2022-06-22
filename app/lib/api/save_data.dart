import 'package:butterfly/api/save_data_stub.dart'
    if (dart.library.io) 'package:butterfly/api/save_data_io.dart'
    if (dart.library.js) 'package:butterfly/api/save_data_html.dart'
    as save_data;
import 'package:flutter/material.dart';

Future<void> saveData(BuildContext context, String data) async {
  save_data.saveData(context, data);
}
