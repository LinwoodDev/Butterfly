import 'package:keybinder/keybinder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKeybinderStore implements KeybinderStore {
  static const String _key = 'keybinder_shortcuts';

  @override
  Future<String?> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  @override
  Future<void> save(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, data);
  }
}
