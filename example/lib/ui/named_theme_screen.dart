import 'package:flutter/material.dart';
import 'package:themely/themely.dart';

class NamedThemeScreen extends StatelessWidget {
  const NamedThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Named Themes allow you to define completely custom themes beyond the standard Light/Dark/Amoled.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        
        Card(
          child: ListTile(
            title: const Text('Clear Named Theme'),
            subtitle: const Text('Revert to standard mode'),
            trailing: context.themeController.activeNamedTheme == null ? const Icon(Icons.check, color: Colors.green) : null,
            onTap: () {
              context.themeController.clearNamedTheme();
            },
          ),
        ),
        
        const SizedBox(height: 8),
        
        Card(
          color: const Color(0xFFF5F0E8), // Sepia background
          child: ListTile(
            title: const Text('Sepia', style: TextStyle(color: Color(0xFF8B5A2B))),
            subtitle: const Text('Warm reading mode', style: TextStyle(color: Color(0xFFCD853F))),
            trailing: context.themeController.activeNamedTheme == 'sepia' ? const Icon(Icons.check, color: Color(0xFF8B5A2B)) : null,
            onTap: () {
              context.themeController.setNamedTheme('sepia');
            },
          ),
        ),
        
        const SizedBox(height: 8),
        
        Card(
          color: Colors.black,
          child: ListTile(
            title: const Text('High Contrast', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
            subtitle: const Text('Maximum visibility', style: TextStyle(color: Colors.white)),
            trailing: context.themeController.activeNamedTheme == 'high_contrast' ? const Icon(Icons.check, color: Colors.yellow) : null,
            onTap: () {
              context.themeController.setNamedTheme('high_contrast');
            },
          ),
        ),
      ],
    );
  }
}
