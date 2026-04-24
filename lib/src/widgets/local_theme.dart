import 'package:flutter/widgets.dart';

import '../core/app_theme_mode.dart';
import '../core/theme_controller.dart';
import '../core/theme_scope.dart';

class LocalTheme extends StatefulWidget {
  const LocalTheme({
    super.key,
    required this.mode,
    required this.child,
  });

  final AppThemeMode mode;
  final Widget child;

  @override
  State<LocalTheme> createState() => _LocalThemeState();
}

class _LocalThemeState extends State<LocalTheme> {
  late ThemeController _localController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Get the parent controller but create a local one that overrides the mode
    final parentController = ThemeScope.of(context);
    
    _localController = ThemeController(
      lightTheme: parentController.activeThemeData, // this is a bit tricky, ideally we'd pass all themes down
      darkTheme: parentController.activeThemeData,
      amoledTheme: parentController.activeThemeData,
      initialMode: widget.mode,
      animationDuration: parentController.animationDuration,
      animationCurve: parentController.animationCurve,
      transition: parentController.transition,
    );
  }

  @override
  void dispose() {
    _localController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      controller: _localController,
      child: widget.child,
    );
  }
}
