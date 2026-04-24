import 'package:flutter/material.dart';
import 'package:themely/themely.dart';

class ContextShorthandPanel extends StatelessWidget {
  const ContextShorthandPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black87,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Context Extension Values',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Divider(color: Colors.white24),
            _buildRow('context.currentMode', context.currentMode.name),
            _buildRow('context.isDark', context.isDark.toString()),
            _buildRow('context.isLight', context.isLight.toString()),
            _buildRow('context.isAmoled', context.isAmoled.toString()),
            if (context.themeController.activeNamedTheme != null)
              _buildRow('activeNamedTheme', context.themeController.activeNamedTheme!),
            if (context.themeController.isPreviewActive)
              _buildRow('isPreviewActive', 'true (Previewing: ${context.themeController.previewMode?.name})'),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontFamily: 'monospace', fontSize: 12),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
