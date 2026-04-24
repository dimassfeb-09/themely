import 'package:flutter/widgets.dart';

import '../core/app_theme_mode.dart';
import '../core/theme_controller.dart';
import '../core/theme_scope.dart';
import '../tokens/app_theme_tokens.dart';
import '../tokens/theme_extension.dart';

extension ThemelyContextExt on BuildContext {
  /// True if the current active mode is [AppThemeMode.dark] or [AppThemeMode.amoled]
  bool get isDark {
    final mode = themeController.activeMode;
    return mode == AppThemeMode.dark || mode == AppThemeMode.amoled;
  }

  /// True if the current active mode is [AppThemeMode.light]
  bool get isLight => themeController.activeMode == AppThemeMode.light;

  /// True if the current active mode is [AppThemeMode.amoled]
  bool get isAmoled => themeController.activeMode == AppThemeMode.amoled;

  /// Returns the current active [AppThemeMode]
  AppThemeMode get currentMode => themeController.activeMode;

  /// Returns semantic color tokens (base type).
  AppThemeTokens get themeColors => themeTokens<AppThemeTokens>();

  /// Returns semantic color tokens with a specific custom type.
  /// Use `context.themeTokens<MyTokens>()` if you have a custom subclass.
  T themeTokens<T extends AppThemeTokens>() => AppThemeExtension.of<T>(this).tokens;

  /// Returns the [ThemeController] instance
  ThemeController get themeController => ThemeScope.of(this);

  /// Helper to return a generic value based on the current active mode.
  /// Works similarly to [ThemeValue] widget but as a synchronous function.
  T themeValue<T>({
    required T light,
    T? dark,
    T? amoled,
    T? orElse,
  }) {
    final mode = themeController.activeMode;

    switch (mode) {
      case AppThemeMode.light:
        return light;
      case AppThemeMode.dark:
        return dark ?? orElse ?? light;
      case AppThemeMode.amoled:
        return amoled ?? dark ?? orElse ?? light;
      case AppThemeMode.system:
        // Use media query to check brightness when system mode is used
        final brightness = MediaQuery.platformBrightnessOf(this);
        if (brightness == Brightness.dark) {
          return dark ?? orElse ?? light;
        } else {
          return light;
        }
    }
  }
}
