import 'package:flutter/material.dart';
import 'package:themely/themely.dart';
import 'dart:async';

class SchedulerScreen extends StatefulWidget {
  const SchedulerScreen({super.key});

  @override
  State<SchedulerScreen> createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends State<SchedulerScreen> {
  late Timer _timer;
  TimeOfDay _currentTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = TimeOfDay.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // For this example, we show the controller's schedule settings
    // A real app might have a Settings UI to update these in the controller.
    final bool isScheduled = context.themeController.autoSchedule;
    final TimeOfDay? from = context.themeController.darkFrom;
    final TimeOfDay? until = context.themeController.darkUntil;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Scheduled Auto Switch allows the app to automatically transition '
          'between light and dark modes based on the time of day.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'Current Local Time',
                  style: TextStyle(
                    color: context.themeColors.contrastOn(context.themeColors.cardSurface),
                  ),
                ),
                Text(
                  _currentTime.format(context),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),
        
        ListTile(
          title: const Text('Auto Schedule'),
          subtitle: const Text('Enabled in ThemeController'),
          trailing: Switch(
            value: isScheduled,
            onChanged: null, // Disabled in UI, just showing state
          ),
        ),
        
        if (isScheduled && from != null && until != null) ...[
          const Divider(),
          ListTile(
            leading: const Icon(Icons.nights_stay),
            title: const Text('Dark Mode From'),
            trailing: Text(from.format(context), style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.wb_sunny),
            title: const Text('Dark Mode Until'),
            trailing: Text(until.format(context), style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ] else ...[
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Auto Schedule is currently disabled in main.dart initialization. '
              'Set autoSchedule: true and provide darkFrom/darkUntil to test this feature.',
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ],
    );
  }
}
