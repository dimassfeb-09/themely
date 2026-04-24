import 'package:flutter/widgets.dart';
import 'brightness_helper.dart';
import 'app_theme_icons.dart';

class AppThemeTokens {
  const AppThemeTokens({
    required this.buttonBackground,
    required this.cardSurface,
    required this.inputBorder,
    required this.inputFocusRing,
    required this.dividerColor,
    required this.overlayScrim,
    required this.textPrimary,
    required this.textSecondary,
    required this.textInverse,
    required this.primaryFont,
    required this.secondaryFont,
    required this.icons,
  });

  final Color buttonBackground;
  final Color cardSurface;
  final Color inputBorder;
  final Color inputFocusRing;
  final Color dividerColor;
  final Color overlayScrim;
  final Color textPrimary;
  final Color textSecondary;
  final Color textInverse;
  final String primaryFont;
  final String secondaryFont;
  final AppThemeIcons icons;

  AppThemeTokens copyWith({
    Color? buttonBackground,
    Color? cardSurface,
    Color? inputBorder,
    Color? inputFocusRing,
    Color? dividerColor,
    Color? overlayScrim,
    Color? textPrimary,
    Color? textSecondary,
    Color? textInverse,
    String? primaryFont,
    String? secondaryFont,
    AppThemeIcons? icons,
  }) {
    return AppThemeTokens(
      buttonBackground: buttonBackground ?? this.buttonBackground,
      cardSurface: cardSurface ?? this.cardSurface,
      inputBorder: inputBorder ?? this.inputBorder,
      inputFocusRing: inputFocusRing ?? this.inputFocusRing,
      dividerColor: dividerColor ?? this.dividerColor,
      overlayScrim: overlayScrim ?? this.overlayScrim,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textInverse: textInverse ?? this.textInverse,
      primaryFont: primaryFont ?? this.primaryFont,
      secondaryFont: secondaryFont ?? this.secondaryFont,
      icons: icons ?? this.icons,
    );
  }

  AppThemeTokens lerp(AppThemeTokens? other, double t) {
    if (other == null) return this;
    return AppThemeTokens(
      buttonBackground:
          Color.lerp(buttonBackground, other.buttonBackground, t)!,
      cardSurface: Color.lerp(cardSurface, other.cardSurface, t)!,
      inputBorder: Color.lerp(inputBorder, other.inputBorder, t)!,
      inputFocusRing: Color.lerp(inputFocusRing, other.inputFocusRing, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      overlayScrim: Color.lerp(overlayScrim, other.overlayScrim, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textInverse: Color.lerp(textInverse, other.textInverse, t)!,
      // Fonts and Icons don't lerp, we just pick the nearest one
      primaryFont: t < 0.5 ? primaryFont : other.primaryFont,
      secondaryFont: t < 0.5 ? secondaryFont : other.secondaryFont,
      icons: t < 0.5 ? icons : other.icons,
    );
  }

  /// Helper to automatically determine foreground text/icon color
  /// based on a given background color using WCAG luminance rules.
  Color contrastOn(Color background) => BrightnessHelper.contrastOn(background);

  // Predefined default token sets
  static AppThemeTokens get light => AppThemeTokens(
        buttonBackground: const Color(0xFF6750A4),
        cardSurface: const Color(0xFFFFFFFF),
        inputBorder: const Color(0xFF79747E),
        inputFocusRing: const Color(0xFF6750A4),
        dividerColor: const Color(0xFFCAC4D0),
        overlayScrim: const Color(0x52000000),
        textPrimary: const Color(0xFF1C1B1F),
        textSecondary: const Color(0xFF49454F),
        textInverse: const Color(0xFFFFFFFF),
        primaryFont: 'Roboto',
        secondaryFont: 'Roboto',
        icons: AppThemeIcons.material,
      );

  static AppThemeTokens get dark => AppThemeTokens(
        buttonBackground: const Color(0xFFD0BCFF),
        cardSurface: const Color(0xFF1D1B20),
        inputBorder: const Color(0xFF938F99),
        inputFocusRing: const Color(0xFFD0BCFF),
        dividerColor: const Color(0xFF49454F),
        overlayScrim: const Color(0x52000000),
        textPrimary: const Color(0xFFE6E1E5),
        textSecondary: const Color(0xFFCAC4D0),
        textInverse: const Color(0xFF000000),
        primaryFont: 'Roboto',
        secondaryFont: 'Roboto',
        icons: AppThemeIcons.material,
      );

  static AppThemeTokens get amoled => AppThemeTokens(
        buttonBackground: const Color(0xFFD0BCFF),
        cardSurface: const Color(0xFF000000),
        inputBorder: const Color(0xFF938F99),
        inputFocusRing: const Color(0xFFD0BCFF),
        dividerColor: const Color(0xFF333333),
        overlayScrim: const Color(0x73000000),
        textPrimary: const Color(0xFFFFFFFF),
        textSecondary: const Color(0xFFBDBDBD),
        textInverse: const Color(0xFF000000),
        primaryFont: 'Roboto',
        secondaryFont: 'Roboto',
        icons: AppThemeIcons.material,
      );
}
