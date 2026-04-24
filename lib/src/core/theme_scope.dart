import 'package:flutter/widgets.dart';
import 'theme_controller.dart';

class ThemeScope extends InheritedWidget {
  const ThemeScope({
    super.key,
    required this.controller,
    required super.child,
  });

  final ThemeController controller;

  static ThemeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeScope>();
    assert(
      scope != null,
      '[themely] WARNING: ThemeScope is not found in the widget tree. '
      'Make sure you have wrapped your app with ThemelyApp or ThemeScope.',
    );
    return scope!.controller;
  }

  @override
  bool updateShouldNotify(ThemeScope oldWidget) {
    return controller != oldWidget.controller;
  }
}
