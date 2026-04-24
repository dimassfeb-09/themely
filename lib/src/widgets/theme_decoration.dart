import 'package:flutter/widgets.dart';
import '../extensions/build_context_ext.dart';

class ThemeDecoration extends StatelessWidget {
  const ThemeDecoration({
    super.key,
    required this.light,
    this.dark,
    this.amoled,
    required this.child,
  });

  final BoxDecoration light;
  final BoxDecoration? dark;
  final BoxDecoration? amoled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final decoration = context.themeValue<BoxDecoration>(
      light: light,
      dark: dark,
      amoled: amoled,
    );

    return DecoratedBox(
      decoration: decoration,
      child: child,
    );
  }
}
