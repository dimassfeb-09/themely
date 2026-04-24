import 'package:flutter/widgets.dart';
import '../extensions/build_context_ext.dart';

class ThemeIcon extends StatelessWidget {
  const ThemeIcon({
    super.key,
    required this.light,
    this.dark,
    this.amoled,
    this.size,
    this.color,
  });

  final IconData light;
  final IconData? dark;
  final IconData? amoled;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final icon = context.themeValue<IconData>(
      light: light,
      dark: dark,
      amoled: amoled,
    );

    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
