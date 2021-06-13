import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// provides the currently selected theme, saves changed theme preferences to disk
class ThemeController extends ChangeNotifier {
  static const themePrefKey = 'theme';

  ThemeController(this._prefs) {
    // load theme from preferences on initialization
    _currentTheme = ThemeMode.values[_prefs.getInt(themePrefKey) ?? 0];
  }

  final SharedPreferences _prefs;
  late ThemeMode _currentTheme;

  /// get the current theme
  ThemeMode get currentTheme => _currentTheme;

  set currentTheme(ThemeMode theme) {
    _currentTheme = theme;

    // notify the app that the theme was changed
    notifyListeners();

    // store updated theme on disk
    _prefs.setInt(themePrefKey, theme.index);
  }

  /// get the controller from any page of your app
  static ThemeController? of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<ThemeControllerProvider>();
    return provider?.controller;
  }
}

/// provides the theme controller to any page of your app
class ThemeControllerProvider extends InheritedWidget {
  const ThemeControllerProvider({Key? key, required this.controller, required Widget child})
      : super(key: key, child: child);

  final ThemeController controller;

  @override
  bool updateShouldNotify(ThemeControllerProvider oldWidget) => controller != oldWidget.controller;
}
