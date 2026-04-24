import 'package:flutter/material.dart';
import 'package:themely/themely.dart';

class CoreToggleScreen extends StatelessWidget {
  const CoreToggleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: context.themeColors.cardSurface,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'Active Mode',
                    style: TextStyle(
                      fontSize: 16,
                      color: context.themeColors.contrastOn(context.themeColors.cardSurface),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.currentMode.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: context.themeColors.buttonBackground,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Select Mode:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: AppThemeMode.values.map((mode) {
              final isActive = context.currentMode == mode;
              return ChoiceChip(
                label: Text(mode.name),
                selected: isActive,
                onSelected: (selected) {
                  if (selected) {
                    // Clear named theme first if any
                    context.themeController.clearNamedTheme();
                    context.themeController.setMode(mode);
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            icon: const Icon(Icons.brightness_6),
            label: const Text('Toggle Dark / Light'),
            onPressed: () {
              context.themeController.clearNamedTheme();
              context.themeController.toggleDark();
            },
          ),
        ],
      ),
    );
  }
}
