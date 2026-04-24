import 'dart:async';
import 'package:flutter/material.dart';

import '../core/app_theme_mode.dart';
import '../core/theme_controller.dart';

class ThemeScheduler {
  ThemeScheduler({
    required this.controller,
    required this.darkFrom,
    required this.darkUntil,
  });

  final ThemeController controller;
  final TimeOfDay darkFrom;
  final TimeOfDay darkUntil;

  Timer? _timer;
  bool _isRunning = false;

  bool get isRunning => _isRunning;

  void start() {
    if (_isRunning) return;
    _isRunning = true;
    
    // Check immediately
    _checkSchedule();
    
    // Check every minute
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      _checkSchedule();
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;
  }

  void dispose() {
    stop();
  }

  void _checkSchedule() {
    final now = TimeOfDay.now();
    final isDarkPeriod = _isTimeBetween(now, darkFrom, darkUntil);

    // If currently previewing or using amoled/system, we might not want to auto switch
    // depending on exact requirements. Here we assume auto-schedule overrides
    // light/dark only, not named themes or previews.
    if (controller.isPreviewActive || controller.activeNamedTheme != null) {
      return;
    }

    if (isDarkPeriod && controller.currentMode == AppThemeMode.light) {
      controller.setMode(AppThemeMode.dark);
    } else if (!isDarkPeriod && controller.currentMode == AppThemeMode.dark) {
      controller.setMode(AppThemeMode.light);
    }
  }

  bool _isTimeBetween(TimeOfDay time, TimeOfDay start, TimeOfDay end) {
    final nowMinutes = time.hour * 60 + time.minute;
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;

    if (startMinutes < endMinutes) {
      // Example: 08:00 to 18:00
      return nowMinutes >= startMinutes && nowMinutes < endMinutes;
    } else {
      // Example: 18:00 to 06:00 (crosses midnight)
      return nowMinutes >= startMinutes || nowMinutes < endMinutes;
    }
  }
}
