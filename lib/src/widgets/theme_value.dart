import 'package:flutter/widgets.dart';
import '../extensions/build_context_ext.dart';

class ThemeValue<T> extends StatelessWidget {
  const ThemeValue({
    super.key,
    required this.light,
    this.dark,
    this.amoled,
    required this.builder,
  });

  final T light;
  final T? dark;
  final T? amoled;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    final value = context.themeValue<T>(
      light: light,
      dark: dark,
      amoled: amoled,
    );

    return builder(context, value);
  }
}
