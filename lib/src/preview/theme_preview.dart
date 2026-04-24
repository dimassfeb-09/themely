import 'package:flutter/widgets.dart';

class ThemePreview extends StatelessWidget {
  const ThemePreview({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
// Note: Actual preview logic is handled entirely by ThemeController's activeMode
// getting the previewMode instead of currentMode when isPreviewActive is true.
