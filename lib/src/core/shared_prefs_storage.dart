import 'package:shared_preferences/shared_preferences.dart';
import 'theme_storage.dart';

class SharedPrefsStorage implements ThemeStorage {
  @override
  Future<void> saveMode(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<String?> loadMode(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
