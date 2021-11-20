import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> formatDateTime(Locale? locale, DateTime dateTime) async {
  var prefs = await SharedPreferences.getInstance();
  return DateFormat(prefs.getString('date_format'), locale?.toString())
      .format(dateTime);
}

Future<String> formatCurrentDateTime(Locale? locale) {
  return formatDateTime(locale, DateTime.now());
}
