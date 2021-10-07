import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale?> {
  LanguageCubit([Locale? locale]) : super(locale);
  LanguageCubit.fromLanguageCode([String? languageCode])
      : super(languageCode == null ? null : Locale(languageCode));

  void change(String? language) async {
    Locale? locale;
    switch (language) {
      case 'en':
        locale = const Locale('en');
        break;
      case 'de':
        locale = const Locale('de');
        break;
      default:
        locale = null;
    }
    emit(locale);
  }

  void reset() {
    emit(null);
  }

  Future<void> save() => SharedPreferences.getInstance()
      .then((value) => value.setString('language', state.toString()));
}
