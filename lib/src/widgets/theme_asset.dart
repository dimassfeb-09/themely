import 'package:flutter/widgets.dart';
import '../extensions/build_context_ext.dart';

class ThemeAsset extends StatelessWidget {
  const ThemeAsset({
    super.key,
    required this.light,
    this.dark,
    this.amoled,
  });

  final ImageProvider light;
  final ImageProvider? dark;
  final ImageProvider? amoled;

  @override
  Widget build(BuildContext context) {
    final asset = context.themeValue<ImageProvider>(
      light: light,
      dark: dark,
      amoled: amoled,
    );

    return Image(image: asset);
  }
}
