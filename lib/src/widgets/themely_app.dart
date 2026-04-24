import 'package:flutter/material.dart';

import '../core/app_theme_mode.dart';
import '../core/theme_controller.dart';
import '../core/theme_scope.dart';

class ThemelyApp extends StatefulWidget {
  const ThemelyApp({
    super.key,
    required this.controller,
    required this.builder,
    this.child,
  });

  final ThemeController controller;
  final Widget Function(BuildContext context, ThemeData theme, Widget? child) builder;
  final Widget? child;

  @override
  State<ThemelyApp> createState() => _ThemelyAppState();
}

class _ThemelyAppState extends State<ThemelyApp> {
  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      controller: widget.controller,
      child: StreamBuilder<AppThemeMode>(
        stream: widget.controller.modeStream,
        initialData: widget.controller.currentMode,
        builder: (context, snapshot) {
          final theme = widget.controller.activeThemeData;
          return AnimatedTheme(
            data: theme,
            duration: widget.controller.animationDuration,
            curve: widget.controller.animationCurve,
            child: widget.builder(
              context,
              theme,
              widget.child,
            ),
          );
        },
      ),
    );
  }
}
