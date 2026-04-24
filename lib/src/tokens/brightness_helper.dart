import 'package:flutter/widgets.dart';

class BrightnessHelper {
  /// Returns [onDark] if [background] is dark, otherwise returns [onLight].
  /// This is useful for automatically determining text or icon colors based on
  /// the dynamic background color.
  static Color contrastOn(
    Color background, {
    Color onDark = const Color(0xFFFFFFFF),
    Color onLight = const Color(0xFF000000),
  }) {
    // Calculate luminance according to WCAG 2.0 guidelines
    final luminance = background.computeLuminance();
    // A common threshold is 0.179 for deciding between black/white text
    return luminance > 0.179 ? onLight : onDark;
  }
}
