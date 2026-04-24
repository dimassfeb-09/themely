import 'package:flutter/widgets.dart';

import '../core/app_theme_mode.dart';
import '../extensions/build_context_ext.dart';

class ThemeBuilder extends StatelessWidget {
  const ThemeBuilder({
    super.key,
    required this.light,
    this.dark,
    this.amoled,
    this.system,
    this.orElse,
  });

  final WidgetBuilder light;
  final WidgetBuilder? dark;
  final WidgetBuilder? amoled;
  final WidgetBuilder? system;
  final WidgetBuilder? orElse;

  @override
  Widget build(BuildContext context) {
    final mode = context.currentMode;

    switch (mode) {
      case AppThemeMode.light:
        return light(context);
      case AppThemeMode.dark:
        if (dark != null) return dark!(context);
        if (orElse != null) return orElse!(context);
        return light(context);
      case AppThemeMode.amoled:
        if (amoled != null) return amoled!(context);
        if (dark != null) return dark!(context);
        if (orElse != null) return orElse!(context);
        return light(context);
      case AppThemeMode.system:
        if (system != null) return system!(context);
        
        final brightness = MediaQuery.platformBrightnessOf(context);
        if (brightness == Brightness.dark) {
          if (dark != null) return dark!(context);
          if (orElse != null) return orElse!(context);
        }
        return light(context);
    }
  }
}
