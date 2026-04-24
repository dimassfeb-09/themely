import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StorageAdapterScreen extends StatefulWidget {
  const StorageAdapterScreen({super.key});

  @override
  State<StorageAdapterScreen> createState() => _StorageAdapterScreenState();
}

class _StorageAdapterScreenState extends State<StorageAdapterScreen> {
  String _storageData = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadStorageData();
  }

  Future<void> _loadStorageData() async {
    // In this example we just read directly from SharedPreferences since
    // it's the default adapter. For custom adapters, you'd query them directly.
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final Map<String, dynamic> data = {};
      final keys = prefs.getKeys();
      for (final key in keys) {
        if (key.startsWith('themely_')) {
          data[key] = prefs.get(key);
        }
      }
      
      if (mounted) {
        setState(() {
          if (data.isEmpty) {
            _storageData = 'No themely data found in storage.';
          } else {
            _storageData = data.entries.map((e) => '${e.key}: ${e.value}').join('\n');
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _storageData = 'Error loading storage data: $e';
        });
      }
    }
  }

  Future<void> _clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((k) => k.startsWith('themely_')).toList();
    for (final key in keys) {
      await prefs.remove(key);
    }
    await _loadStorageData();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Themely storage cleared!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Themely uses a ThemeStorage abstraction. The default uses SharedPreferences, '
          'but you can provide a custom adapter like Hive, Isar, or in-memory storage.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),
        
        ListTile(
          title: const Text('Current Adapter'),
          subtitle: const Text('SharedPrefsStorage (Default)'),
          leading: const Icon(Icons.storage),
          trailing: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadStorageData,
          ),
        ),
        
        const SizedBox(height: 16),
        const Text('Storage Contents:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            _storageData,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: Colors.greenAccent,
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
          icon: const Icon(Icons.delete_forever),
          label: const Text('Clear Storage'),
          onPressed: _clearStorage,
        ),
      ],
    );
  }
}
