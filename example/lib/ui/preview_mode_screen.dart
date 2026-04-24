import 'package:flutter/material.dart';
import 'package:themely/themely.dart';

class PreviewModeScreen extends StatelessWidget {
  const PreviewModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppThemeMode>(
      stream: context.themeController.modeStream,
      builder: (context, snapshot) {
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Preview Mode allows you to temporarily apply a theme without saving it to storage. '
                'This is perfect for settings pages where users can preview a theme before confirming.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              child: ListView(
                children: AppThemeMode.values.map((mode) {
                  return ListTile(
                    title: Text(mode.name),
                    leading: Icon(mode == context.themeController.activeMode ? Icons.check_circle : Icons.circle_outlined),
                    onTap: () {
                      context.themeController.preview(mode);
                    },
                  );
                }).toList(),
              ),
            ),
            if (context.themeController.isPreviewActive)
              Container(
                padding: const EdgeInsets.all(16),
                color: context.themeColors.cardSurface,
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            context.themeController.cancelPreview();
                          },
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await context.themeController.confirmPreview();
                          },
                          child: const Text('Confirm'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      }
    );
  }
}
