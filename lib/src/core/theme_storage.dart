// lib/src/core/theme_storage.dart
abstract class ThemeStorage {
  Future<void> saveMode(String key, String value);
  Future<String?> loadMode(String key);
  Future<void> clear();
}
