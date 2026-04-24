import 'package:flutter/material.dart';
import 'package:themely/themely.dart';

class SubtreeOverrideScreen extends StatelessWidget {
  const SubtreeOverrideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'LocalTheme widget allows a specific part of the widget tree to use a different theme mode than the global app mode.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 32),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildCard(
                  context,
                  title: 'Global Mode',
                  description: 'This card follows the global application mode.',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: LocalTheme(
                  mode: context.isDark ? AppThemeMode.light : AppThemeMode.dark,
                  child: Builder(
                    builder: (localContext) {
                      return _buildCard(
                        localContext,
                        title: 'Local Override',
                        description: 'This card is wrapped in LocalTheme and always uses the opposite of the global mode.',
                        isLocal: true,
                      );
                    }
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.themeController.toggleDark(),
            child: const Text('Toggle Global Mode'),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required String title, required String description, bool isLocal = false}) {
    return Card(
      color: context.themeColors.cardSurface,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: context.themeColors.contrastOn(context.themeColors.cardSurface),
              ),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            Text(
              'Active Mode:',
              style: TextStyle(color: context.themeColors.contrastOn(context.themeColors.cardSurface)),
            ),
            Text(
              context.currentMode.name.toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.themeColors.buttonBackground,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: context.themeColors.contrastOn(context.themeColors.cardSurface).withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
