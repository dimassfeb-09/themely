import 'package:flutter_test/flutter_test.dart';
import 'package:themely/themely.dart';
import 'package:mocktail/mocktail.dart';

class MockThemeStorage extends Mock implements ThemeStorage {}

void main() {
  group('ThemeController', () {
    late MockThemeStorage mockStorage;

    setUp(() {
      mockStorage = MockThemeStorage();
      when(() => mockStorage.loadMode(any())).thenAnswer((_) async => null);
      when(() => mockStorage.saveMode(any(), any())).thenAnswer((_) async => {});
    });

    test('initializes with default mode', () async {
      final controller = ThemeController(storage: mockStorage);
      await controller.initialize();
      expect(controller.currentMode, AppThemeMode.system);
    });

    test('loads saved mode', () async {
      when(() => mockStorage.loadMode('themely_mode')).thenAnswer((_) async => 'dark');
      final controller = ThemeController(storage: mockStorage);
      await controller.initialize();
      expect(controller.currentMode, AppThemeMode.dark);
    });

    test('toggles dark mode', () async {
      final controller = ThemeController(initialMode: AppThemeMode.light, storage: mockStorage);
      await controller.initialize();
      expect(controller.currentMode, AppThemeMode.light);

      await controller.toggleDark();
      expect(controller.currentMode, AppThemeMode.dark);

      await controller.toggleDark();
      expect(controller.currentMode, AppThemeMode.light);
    });
    
    test('preview mode logic', () async {
      final controller = ThemeController(initialMode: AppThemeMode.light, storage: mockStorage);
      await controller.initialize();
      
      expect(controller.currentMode, AppThemeMode.light);
      expect(controller.isPreviewActive, false);
      expect(controller.activeMode, AppThemeMode.light);
      
      controller.preview(AppThemeMode.amoled);
      expect(controller.currentMode, AppThemeMode.light);
      expect(controller.isPreviewActive, true);
      expect(controller.previewMode, AppThemeMode.amoled);
      expect(controller.activeMode, AppThemeMode.amoled);
      
      controller.cancelPreview();
      expect(controller.isPreviewActive, false);
      expect(controller.activeMode, AppThemeMode.light);
      
      controller.preview(AppThemeMode.dark);
      await controller.confirmPreview();
      expect(controller.isPreviewActive, false);
      expect(controller.currentMode, AppThemeMode.dark);
      expect(controller.activeMode, AppThemeMode.dark);
    });
  });
}
