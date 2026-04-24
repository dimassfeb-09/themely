import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:themely/themely.dart';

class SeedGeneratorScreen extends StatefulWidget {
  const SeedGeneratorScreen({super.key});

  @override
  State<SeedGeneratorScreen> createState() => _SeedGeneratorScreenState();
}

class _SeedGeneratorScreenState extends State<SeedGeneratorScreen> {
  Color _seedColor = Colors.blue;
  ThemeData? _generatedLight;
  ThemeData? _generatedDark;

  @override
  void initState() {
    super.initState();
    _generateTheme();
  }

  void _generateTheme() {
    final themes = SeedThemeGenerator.fromSeed(_seedColor);
    setState(() {
      _generatedLight = themes.light;
      _generatedDark = themes.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Generate a complete Light and Dark theme dynamically from a single seed color.',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Pick a seed color'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: _seedColor,
                      onColorChanged: (color) {
                        setState(() => _seedColor = color);
                        _generateTheme();
                      },
                      pickerAreaHeightPercent: 0.8,
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Pick Seed Color'),
        ),
        const SizedBox(height: 16),
        if (_generatedLight != null && _generatedDark != null)
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildThemePreview('Generated Light', _generatedLight!)),
                Expanded(child: _buildThemePreview('Generated Dark', _generatedDark!)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildThemePreview(String title, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      color: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          _colorRow('Primary', theme.colorScheme.primary, theme.colorScheme.onPrimary),
          _colorRow('Secondary', theme.colorScheme.secondary, theme.colorScheme.onSecondary),
          _colorRow('Surface', theme.colorScheme.surface, theme.colorScheme.onSurface),
          _colorRow('Error', theme.colorScheme.error, theme.colorScheme.onError),
          
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
            ),
            onPressed: () {},
            child: const Text('Button'),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            backgroundColor: theme.colorScheme.secondary,
            foregroundColor: theme.colorScheme.onSecondary,
            onPressed: () {},
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }

  Widget _colorRow(String name, Color color, Color textColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
