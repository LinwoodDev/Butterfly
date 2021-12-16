import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class ButterflySettings {
  final ThemeMode theme;
  final String localeTag;
  final String documentPath;
  final String dateFormat;
  final InputType inputType;

  const ButterflySettings(
      {this.theme = ThemeMode.system,
      this.localeTag = '',
      this.documentPath = '',
      this.dateFormat = '',
      this.inputType = InputType.multiDraw});

  ButterflySettings.fromPrefs(SharedPreferences prefs)
      : localeTag = prefs.getString('locale') ?? '',
        inputType = InputType.values[prefs.getInt('input') ?? 0],
        documentPath = prefs.getString('document_path') ?? '',
        theme = ThemeMode.values[prefs.getInt('theme') ?? 0],
        dateFormat = prefs.getString('date_format') ?? '';

  Locale? get locale => localeTag.isEmpty ? null : Locale(localeTag);

  ButterflySettings copyWith(
          {ThemeMode? theme,
          String? localeTag,
          String? documentPath,
          String? dateFormat,
          InputType? inputType}) =>
      ButterflySettings(
          theme: theme ?? this.theme,
          documentPath: documentPath ?? this.documentPath,
          dateFormat: dateFormat ?? this.dateFormat,
          inputType: inputType ?? this.inputType,
          localeTag: localeTag ?? this.localeTag);

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', theme.index);
    await prefs.setString('locale', localeTag);
    await prefs.setInt('input', inputType.index);
    await prefs.setString('date_format', dateFormat);
    await prefs.setString('document_path', documentPath);
  }
}

enum InputType { multiDraw, moveFirst, moveLast, onlyStylus }

extension InputTypeExtension on InputType {
  String toLocalizedString(BuildContext context) {
    switch (this) {
      case InputType.multiDraw:
        return AppLocalizations.of(context)!.multiDraw;
      case InputType.moveFirst:
        return AppLocalizations.of(context)!.moveFirst;
      case InputType.moveLast:
        return AppLocalizations.of(context)!.moveLast;
      case InputType.onlyStylus:
        return AppLocalizations.of(context)!.onlyStylus;
    }
  }

  bool canCreate(int pointer, int? first, PointerDeviceKind kind) =>
      this == InputType.onlyStylus && kind == PointerDeviceKind.stylus ||
      this == InputType.moveFirst && (pointer != first || first != null) ||
      this == InputType.moveLast && (pointer == first || first == null) ||
      this == InputType.multiDraw;
}

class SettingsCubit extends Cubit<ButterflySettings> {
  SettingsCubit() : super(const ButterflySettings());

  SettingsCubit.fromPrefs(SharedPreferences prefs)
      : super(ButterflySettings.fromPrefs(prefs));

  Future<void> changeTheme(ThemeMode theme) async {
    emit(state.copyWith(theme: theme));
  }

  Future<void> changeLocale(Locale? locale) {
    emit(state.copyWith(localeTag: locale?.toString() ?? ''));
    return save();
  }

  Future<void> resetLocale() {
    emit(state.copyWith(localeTag: ''));
    return save();
  }

  Future<void> changeDocumentPath(String documentPath) {
    emit(state.copyWith(documentPath: documentPath));
    return save();
  }

  Future<void> resetDocumentPath() {
    emit(state.copyWith(documentPath: ''));
    return save();
  }

  Future<void> changeDateFormat(String dateFormat) {
    emit(state.copyWith(dateFormat: dateFormat));
    return save();
  }

  Future<void> resetDateFormat() {
    emit(state.copyWith(dateFormat: ''));
    return save();
  }

  Future<void> changeInput(InputType inputType) {
    emit(state.copyWith(inputType: inputType));
    return save();
  }

  Future<void> resetInput() {
    emit(state.copyWith(inputType: InputType.multiDraw));
    return save();
  }

  Future<void> save() => state.save();
}
