import 'package:flutter/widgets.dart';
import '../extensions/build_context_ext.dart';

class ThemeShadow extends StatelessWidget {
  const ThemeShadow({
    super.key,
    required this.light,
    this.dark,
    this.amoled,
    required this.child,
  });

  final List<BoxShadow> light;
  final List<BoxShadow>? dark;
  final List<BoxShadow>? amoled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final shadows = context.themeValue<List<BoxShadow>>(
      light: light,
      dark: dark,
      amoled: amoled,
    );

    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: shadows),
      child: child,
    );
  }
}
