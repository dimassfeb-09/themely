import 'package:flutter/material.dart';

class AppThemeIcons {
  const AppThemeIcons({
    required this.home,
    required this.settings,
    required this.back,
    required this.forward,
    required this.info,
    required this.error,
    required this.success,
    required this.themeMode,
  });

  final IconData home;
  final IconData settings;
  final IconData back;
  final IconData forward;
  final IconData info;
  final IconData error;
  final IconData success;
  final IconData themeMode;

  AppThemeIcons copyWith({
    IconData? home,
    IconData? settings,
    IconData? back,
    IconData? forward,
    IconData? info,
    IconData? error,
    IconData? success,
    IconData? themeMode,
  }) {
    return AppThemeIcons(
      home: home ?? this.home,
      settings: settings ?? this.settings,
      back: back ?? this.back,
      forward: forward ?? this.forward,
      info: info ?? this.info,
      error: error ?? this.error,
      success: success ?? this.success,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  /// Default Material Icons
  static AppThemeIcons get material => const AppThemeIcons(
        home: Icons.home_rounded,
        settings: Icons.settings_rounded,
        back: Icons.arrow_back_ios_new_rounded,
        forward: Icons.arrow_forward_ios_rounded,
        info: Icons.info_outline_rounded,
        error: Icons.error_outline_rounded,
        success: Icons.check_circle_outline_rounded,
        themeMode: Icons.brightness_medium_rounded,
      );

  /// Example Sharp Icons
  static AppThemeIcons get sharp => const AppThemeIcons(
        home: Icons.home_sharp,
        settings: Icons.settings_sharp,
        back: Icons.arrow_back_sharp,
        forward: Icons.arrow_forward_sharp,
        info: Icons.info_sharp,
        error: Icons.error_sharp,
        success: Icons.check_circle_sharp,
        themeMode: Icons.brightness_4_sharp,
      );
}
