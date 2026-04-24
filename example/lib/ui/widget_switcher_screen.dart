import 'package:flutter/material.dart';
import 'package:themely/themely.dart';

class WidgetSwitcherScreen extends StatelessWidget {
  const WidgetSwitcherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'These widgets automatically switch their contents based on the active theme mode without requiring setState.',
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('ThemeBuilder'),
        ThemeBuilder(
          light: (context) => const Chip(
              label: Text('LIGHT LAYOUT'), backgroundColor: Colors.amber),
          dark: (context) => const Chip(
              label: Text('DARK LAYOUT'), backgroundColor: Colors.grey),
          amoled: (context) => const Chip(
              label: Text('AMOLED LAYOUT'),
              backgroundColor: Colors.black,
              labelStyle: TextStyle(color: Colors.white)),
          orElse: (context) => const Chip(label: Text('FALLBACK LAYOUT')),
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('ThemeIcon'),
        ThemeIcon(
          light: Icons.wb_sunny,
          dark: Icons.nightlight_round,
          amoled: Icons.bedtime,
          size: 48,
          color: context.themeColors.buttonBackground,
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('ThemeText'),
        const ThemeText(
          light: 'This is the Light Text',
          dark: 'This is the Dark Text',
          amoled: 'This is the Amoled Text',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('ThemeAnimatedColor'),
        ThemeAnimatedColor(
          light: Colors.orange,
          dark: Colors.deepPurple,
          amoled: Colors.black,
          builder: (context, color) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.themeColors.dividerColor),
              ),
              child: Center(
                child: Text(
                  'Animated Color Box',
                  style:
                      TextStyle(color: context.themeColors.contrastOn(color)),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('ThemeDecoration & ThemeShadow'),
        ThemeDecoration(
          light: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blueAccent, width: 2),
          ),
          dark: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.deepPurpleAccent, width: 2),
          ),
          child: const ThemeShadow(
            light: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
            ],
            dark: [
              BoxShadow(
                  color: Colors.white24, blurRadius: 5, offset: Offset(0, 2))
            ],
            amoled: [
              BoxShadow(
                  color: Colors.redAccent, blurRadius: 15, spreadRadius: 2)
            ],
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text('Card with dynamic decoration and shadow',
                  textAlign: TextAlign.center),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }
}
