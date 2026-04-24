import 'dart:async';
import 'package:flutter/material.dart';
import 'package:themely/themely.dart';

class StreamLogScreen extends StatefulWidget {
  const StreamLogScreen({super.key});

  @override
  State<StreamLogScreen> createState() => _StreamLogScreenState();
}

class _StreamLogScreenState extends State<StreamLogScreen> {
  final List<String> _logs = [];
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    // Schedule to run after the first frame so we have access to context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _subscription = context.themeController.modeStream.listen((mode) {
        if (!mounted) return;
        setState(() {
          final time = DateTime.now().toIso8601String().split('T').last.split('.').first;
          final named = context.themeController.activeNamedTheme;
          final namedStr = named != null ? ' (Named: $named)' : '';
          _logs.insert(0, '[$time] Mode changed to: ${mode.name}$namedStr');
        });
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Live Theme Changes:', style: TextStyle(fontWeight: FontWeight.bold)),
              TextButton.icon(
                icon: const Icon(Icons.clear),
                label: const Text('Clear Log'),
                onPressed: () => setState(() => _logs.clear()),
              ),
            ],
          ),
        ),
        Expanded(
          child: _logs.isEmpty
              ? const Center(child: Text('No changes yet. Try changing mode from the drawer.'))
              : ListView.builder(
                  itemCount: _logs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(_logs[index], style: const TextStyle(fontFamily: 'monospace')),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => context.themeController.cycleMode(),
            child: const Text('Simulate Mode Change (Cycle)'),
          ),
        )
      ],
    );
  }
}
