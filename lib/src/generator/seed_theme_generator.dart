import 'package:flutter/material.dart';

import '../tokens/app_theme_tokens.dart';
import '../tokens/theme_extension.dart';

class SeedThemeGenerator {
  /// Generate both light and dark ThemeData from a single seed color.
  static ({ThemeData light, ThemeData dark}) fromSeed(
    Color seedColor, {
    AppThemeTokens? lightTokens,
    AppThemeTokens? darkTokens,
  }) {
    final lightScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    );

    final darkScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );

    final lightTheme = ThemeData(
      colorScheme: lightScheme,
      useMaterial3: true,
      extensions: [
        AppThemeExtension(tokens: lightTokens ?? AppThemeTokens.light),
      ],
    );

    final darkTheme = ThemeData(
      colorScheme: darkScheme,
      useMaterial3: true,
      extensions: [
        AppThemeExtension(tokens: darkTokens ?? AppThemeTokens.dark),
      ],
    );

    return (light: lightTheme, dark: darkTheme);
  }
}
