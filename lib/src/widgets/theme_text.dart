import 'package:flutter/widgets.dart';
import '../extensions/build_context_ext.dart';

class ThemeText extends StatelessWidget {
  const ThemeText({
    super.key,
    required this.light,
    this.dark,
    this.amoled,
    this.style,
  });

  final String light;
  final String? dark;
  final String? amoled;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final text = context.themeValue<String>(
      light: light,
      dark: dark,
      amoled: amoled,
    );

    return Text(
      text,
      style: style,
    );
  }
}
