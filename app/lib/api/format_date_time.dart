import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

Future<String> formatDateTime(Locale? locale, DateTime dateTime) async {
  return DateFormat('dd/MM/yyyy HH:mm', locale?.toString()).format(dateTime);
}

Future<String> formatCurrentDateTime(Locale? locale) {
  return formatDateTime(locale, DateTime.now());
}
