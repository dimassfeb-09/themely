import 'package:flutter/material.dart';
import 'package:themely/themely.dart';

// Definisi Token untuk mode Sepia
final AppThemeTokens sepiaTokens = AppThemeTokens.light.copyWith(
  buttonBackground: const Color(0xFF8B5A2B),
  cardSurface: const Color(0xFFFDF5E6),
  inputBorder: const Color(0xFFCD853F),
  inputFocusRing: const Color(0xFF8B5A2B),
  dividerColor: const Color(0xFFDEB887),
  textPrimary: const Color(0xFF5D4037),
  textSecondary: const Color(0xFF8D6E63),
  primaryFont: 'Georgia', // Serif font for classic look
  icons: AppThemeIcons.material.copyWith(home: Icons.book_rounded),
);

// Definisi Token untuk mode High Contrast
final AppThemeTokens highContrastTokens = AppThemeTokens.dark.copyWith(
  buttonBackground: const Color(0xFFFFFF00),
  cardSurface: const Color(0xFF000000),
  inputBorder: const Color(0xFFFFFFFF),
  inputFocusRing: const Color(0xFFFFFF00),
  dividerColor: const Color(0xFFFFFFFF),
  textPrimary: const Color(0xFFFFFFFF),
  textSecondary: const Color(0xFFFFFF00),
  primaryFont: 'Courier New', // Monospace for high visibility
  icons: AppThemeIcons.sharp, // Using sharp icons for contrast
);

// ThemeData dasar
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorSchemeSeed: Colors.deepPurple,
  useMaterial3: true,
  extensions: [
    AppThemeExtension(tokens: AppThemeTokens.light),
  ],
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorSchemeSeed: Colors.deepPurple,
  useMaterial3: true,
  extensions: [
    AppThemeExtension(tokens: AppThemeTokens.dark),
  ],
);

final ThemeData amoledTheme = ThemeData(
  brightness: Brightness.dark,
  colorSchemeSeed: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.black,
  useMaterial3: true,
  extensions: [
    AppThemeExtension(tokens: AppThemeTokens.amoled),
  ],
);

// Named Themes
final ThemeData sepiaTheme = ThemeData(
  brightness: Brightness.light,
  colorSchemeSeed: Colors.brown,
  scaffoldBackgroundColor: const Color(0xFFF5F0E8),
  useMaterial3: true,
  extensions: [
    AppThemeExtension(tokens: sepiaTokens),
  ],
);

final ThemeData highContrastTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: const ColorScheme.dark(
    primary: Colors.yellow,
    secondary: Colors.yellowAccent,
    surface: Colors.black,
    error: Colors.redAccent,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    onError: Colors.black,
  ),
  useMaterial3: true,
  extensions: [
    AppThemeExtension(tokens: highContrastTokens),
  ],
);
