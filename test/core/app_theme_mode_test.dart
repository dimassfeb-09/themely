import 'package:flutter_test/flutter_test.dart';
import 'package:themely/themely.dart';

void main() {
  group('AppThemeMode', () {
    test('should have expected values', () {
      expect(AppThemeMode.light.name, 'light');
      expect(AppThemeMode.dark.name, 'dark');
      expect(AppThemeMode.amoled.name, 'amoled');
      expect(AppThemeMode.system.name, 'system');
    });
  });
}
