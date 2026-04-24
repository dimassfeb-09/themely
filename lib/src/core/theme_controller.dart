import 'dart:async';
import 'package:flutter/material.dart';

import 'app_theme_mode.dart';
import 'theme_storage.dart';
import 'shared_prefs_storage.dart';
import '../animation/theme_transition.dart';

class ThemeController {
  ThemeController({
    ThemeData? lightTheme,
    ThemeData? darkTheme,
    ThemeData? amoledTheme,
    this.initialMode = AppThemeMode.system,
    ThemeStorage? storage,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.transition = ThemeTransition.fade,
    this.autoSchedule = false,
    this.darkFrom,
    this.darkUntil,
  }) {
    _lightTheme = lightTheme ?? ThemeData.light();
    _darkTheme = darkTheme ?? ThemeData.dark();
    _amoledTheme = amoledTheme ?? ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
    );
    _storage = storage ?? SharedPrefsStorage();
    _currentMode = initialMode;
    
    // Validate scheduler times
    if (autoSchedule) {
      assert(darkFrom != null && darkUntil != null, 
        'darkFrom and darkUntil must be provided if autoSchedule is true.');
    }
  }

  // Configuration
  final AppThemeMode initialMode;
  late final ThemeData _lightTheme;
  late final ThemeData _darkTheme;
  late final ThemeData _amoledTheme;
  late final ThemeStorage _storage;
  
  final Duration animationDuration;
  final Curve animationCurve;
  final ThemeTransition transition;
  
  final bool autoSchedule;
  final TimeOfDay? darkFrom;
  final TimeOfDay? darkUntil;

  // State
  late AppThemeMode _currentMode;
  AppThemeMode? _previewMode;
  
  // Named themes
  final Map<String, ({ThemeData? light, ThemeData? dark})> _namedThemes = {};
  String? _activeNamedTheme;
  
  // Stream
  final _modeController = StreamController<AppThemeMode>.broadcast();
  Stream<AppThemeMode> get modeStream => _modeController.stream;

  // Getters
  AppThemeMode get currentMode => _currentMode;
  AppThemeMode get activeMode => isPreviewActive ? _previewMode! : _currentMode;
  bool get isPreviewActive => _previewMode != null;
  AppThemeMode? get previewMode => _previewMode;
  String? get activeNamedTheme => _activeNamedTheme;

  ThemeData get activeThemeData {
    final modeToUse = activeMode;
    
    if (_activeNamedTheme != null && _namedThemes.containsKey(_activeNamedTheme)) {
      final namedTheme = _namedThemes[_activeNamedTheme]!;
      if (modeToUse == AppThemeMode.light || modeToUse == AppThemeMode.system /* fallback */) {
        return namedTheme.light ?? _lightTheme;
      } else {
        // Dark or amoled modes will use named theme's dark if available
        // Note: For amoled, we might still want pure black background even with named themes
        final darkData = namedTheme.dark ?? _darkTheme;
        if (modeToUse == AppThemeMode.amoled) {
          return darkData.copyWith(scaffoldBackgroundColor: Colors.black);
        }
        return darkData;
      }
    }

    switch (modeToUse) {
      case AppThemeMode.light:
        return _lightTheme;
      case AppThemeMode.dark:
        return _darkTheme;
      case AppThemeMode.amoled:
        return _amoledTheme;
      case AppThemeMode.system:
        // System is handled at the app level using MediaQuery
        // Here we default to light, but the app widget will determine the actual theme
        return _lightTheme; 
    }
  }

  static const String _storageKeyMode = 'themely_mode';
  static const String _storageKeyNamed = 'themely_named_theme';

  Future<void> initialize() async {
    final savedMode = await _storage.loadMode(_storageKeyMode);
    if (savedMode != null) {
      try {
        _currentMode = AppThemeMode.values.firstWhere((e) => e.name == savedMode);
      } catch (_) {
        _currentMode = initialMode;
      }
    }
    
    final savedNamed = await _storage.loadMode(_storageKeyNamed);
    if (savedNamed != null && _namedThemes.containsKey(savedNamed)) {
      _activeNamedTheme = savedNamed;
    }
    
    _modeController.add(_currentMode);
  }

  Future<void> setMode(AppThemeMode mode) async {
    if (_currentMode == mode) return;
    
    _currentMode = mode;
    _modeController.add(_currentMode);
    await _storage.saveMode(_storageKeyMode, mode.name);
  }

  Future<void> toggleDark() async {
    if (_currentMode == AppThemeMode.dark || _currentMode == AppThemeMode.amoled) {
      await setMode(AppThemeMode.light);
    } else {
      await setMode(AppThemeMode.dark);
    }
  }

  Future<void> cycleMode() async {
    const modes = AppThemeMode.values;
    final currentIndex = modes.indexOf(_currentMode);
    final nextIndex = (currentIndex + 1) % modes.length;
    await setMode(modes[nextIndex]);
  }

  void registerTheme(String name, {ThemeData? light, ThemeData? dark}) {
    _namedThemes[name] = (light: light, dark: dark);
  }

  Future<void> setNamedTheme(String name) async {
    if (!_namedThemes.containsKey(name)) return;
    if (_activeNamedTheme == name) return;
    
    _activeNamedTheme = name;
    _modeController.add(_currentMode); // trigger rebuild
    await _storage.saveMode(_storageKeyNamed, name);
  }
  
  Future<void> clearNamedTheme() async {
    if (_activeNamedTheme == null) return;
    _activeNamedTheme = null;
    _modeController.add(_currentMode);
    await _storage.saveMode(_storageKeyNamed, '');
  }

  void preview(AppThemeMode mode) {
    if (_previewMode == mode) return;
    _previewMode = mode;
    _modeController.add(_currentMode); // trigger rebuild
  }

  Future<void> confirmPreview() async {
    if (_previewMode == null) return;
    final modeToSave = _previewMode!;
    _previewMode = null;
    await setMode(modeToSave);
  }

  void cancelPreview() {
    if (_previewMode == null) return;
    _previewMode = null;
    _modeController.add(_currentMode); // trigger rebuild to restore
  }

  void dispose() {
    _modeController.close();
  }
}
