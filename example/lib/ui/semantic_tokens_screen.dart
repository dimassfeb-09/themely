import 'package:flutter/material.dart';
import 'package:themely/themely.dart';

class SemanticTokensScreen extends StatelessWidget {
  const SemanticTokensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeColors;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'These tokens automatically adjust based on the active mode (Light, Dark, Amoled, Sepia).',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        _buildColorSwatch(context, 'buttonBackground', tokens.buttonBackground),
        _buildColorSwatch(context, 'cardSurface', tokens.cardSurface),
        _buildColorSwatch(context, 'inputBorder', tokens.inputBorder),
        _buildColorSwatch(context, 'inputFocusRing', tokens.inputFocusRing),
        _buildColorSwatch(context, 'dividerColor', tokens.dividerColor),
        _buildColorSwatch(context, 'overlayScrim', tokens.overlayScrim),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () => context.themeController.toggleDark(),
          child: const Text('Toggle Dark Mode (Observe Change)'),
        ),
      ],
    );
  }

  Widget _buildColorSwatch(BuildContext context, String name, Color color) {
    // Determine the optimal text color for the background
    final textColor = context.themeColors.contrastOn(color);
    // Get hex string
    final hexString = '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';

    return Card(
      color: color,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              hexString,
              style: TextStyle(color: textColor, fontFamily: 'monospace'),
            ),
          ],
        ),
      ),
    );
  }
}
