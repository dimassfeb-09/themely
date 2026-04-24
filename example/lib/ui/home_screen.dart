import 'package:flutter/material.dart';
import 'package:themely/themely.dart';
import '../shared/debug_panel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Welcome to Themely Playground',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Use the drawer to navigate between different feature demonstrations.',
            ),
            const SizedBox(height: 32),
            _buildStatusCard(context),
          ],
        ),
        const Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: ContextShorthandPanel(),
        ),
      ],
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Current Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            ListTile(
              title: const Text('Mode'),
              trailing: Text(context.currentMode.name.toUpperCase()),
            ),
            ListTile(
              title: const Text('Named Theme'),
              trailing: Text(context.themeController.activeNamedTheme ?? 'None'),
            ),
            ListTile(
              title: const Text('Scheduler'),
              trailing: Text(context.themeController.autoSchedule ? 'ON' : 'OFF'),
            ),
            ListTile(
              title: const Text('Preview Mode'),
              trailing: Text(context.themeController.isPreviewActive ? 'ACTIVE' : 'INACTIVE'),
            ),
          ],
        ),
      ),
    );
  }
}
