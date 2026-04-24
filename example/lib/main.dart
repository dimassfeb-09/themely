import 'package:example/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:themely/themely.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the controller with your ThemeData
  final controller = ThemeController(
    lightTheme: ThemeData.light(useMaterial3: true).copyWith(
      extensions: [AppThemeExtension(tokens: AppThemeTokens.light)],
    ),
    darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
      extensions: [AppThemeExtension(tokens: AppThemeTokens.dark)],
    ),
    amoledTheme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      cardTheme: const CardThemeData(color: Color(0xFF121212)),
      useMaterial3: true,
      extensions: [AppThemeExtension(tokens: AppThemeTokens.amoled)],
    ),
  );

  // Await initialization to load saved preferences
  await controller.initialize();

  runApp(MyApp(controller: controller));
}

class MyApp extends StatelessWidget {
  final ThemeController controller;

  const MyApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Inject ThemeScope and listen to stream
    return ThemelyApp(
      controller: controller,
      builder: (context, theme, child) =>
          MaterialApp(theme: theme, home: Home()),
    );
  }
}
