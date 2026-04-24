import 'package:flutter/widgets.dart';
import '../extensions/build_context_ext.dart';
import '../core/theme_scope.dart';

class ThemeAnimatedColor extends StatelessWidget {
  const ThemeAnimatedColor({
    super.key,
    required this.light,
    this.dark,
    this.amoled,
    this.duration,
    this.curve,
    required this.builder,
  });

  final Color light;
  final Color? dark;
  final Color? amoled;
  final Duration? duration;
  final Curve? curve;
  final Widget Function(BuildContext context, Color color) builder;

  @override
  Widget build(BuildContext context) {
    final targetColor = context.themeValue<Color>(
      light: light,
      dark: dark,
      amoled: amoled,
    );
    
    final controller = ThemeScope.of(context);

    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: targetColor),
      duration: duration ?? controller.animationDuration,
      curve: curve ?? controller.animationCurve,
      builder: (context, color, child) {
        return builder(context, color ?? targetColor);
      },
    );
  }
}
