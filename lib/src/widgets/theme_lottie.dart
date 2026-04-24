import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import '../extensions/build_context_ext.dart';

class ThemeLottie extends StatelessWidget {
  /// Loads Lottie animations from local assets based on the active theme mode.
  const ThemeLottie.asset({
    super.key,
    required this.light,
    this.dark,
    this.amoled,
    this.controller,
    this.animate,
    this.repeat,
    this.reverse,
    this.width,
    this.height,
    this.fit,
    this.alignment,
  }) : _isNetwork = false;

  /// Loads Lottie animations from network URLs based on the active theme mode.
  const ThemeLottie.network({
    super.key,
    required this.light,
    this.dark,
    this.amoled,
    this.controller,
    this.animate,
    this.repeat,
    this.reverse,
    this.width,
    this.height,
    this.fit,
    this.alignment,
  }) : _isNetwork = true;

  final String light;
  final String? dark;
  final String? amoled;
  final bool _isNetwork;

  // Lottie properties
  final Animation<double>? controller;
  final bool? animate;
  final bool? repeat;
  final bool? reverse;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final source = context.themeValue<String>(
      light: light,
      dark: dark,
      amoled: amoled,
    );

    if (_isNetwork) {
      return Lottie.network(
        source,
        controller: controller,
        animate: animate,
        repeat: repeat,
        reverse: reverse,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
      );
    } else {
      return Lottie.asset(
        source,
        controller: controller,
        animate: animate,
        repeat: repeat,
        reverse: reverse,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
      );
    }
  }
}
