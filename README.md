# Themely 🎨

[![pub package](https://img.shields.io/pub/v/themely.svg)](https://pub.dev/packages/themely)
[![GitHub stars](https://img.shields.io/github/stars/dimassfeb-09/themely.svg?style=social)](https://github.com/dimassfeb-09/themely)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%E2%9C%93-blue.svg)](https://flutter.dev)

A modular, highly customizable Flutter theme manager supporting dark, light and custom named themes with semantic color tokens, animated transitions, scheduling, and more.

<p align="center">
  <img src="https://raw.githubusercontent.com/dimassfeb-09/themely/main/assets/Preview.gif" alt="Themely Preview" width="350" style="max-width: 100%;">
</p>

## Table of Contents
1. [Features](#features)
2. [Requirements](#requirements)
3. [Installation](#installation)
4. [Getting Started](#getting-started)
5. [Quick Start](#quick-start)
6. [Customization](#customization)
7. [API Reference](#api-reference)
8. [Cookbook & FAQ](#cookbook--faq)
9. [Contributing](#contributing)
10. [Support](#support)
11. [Contributors](#contributors)
12. [Changelog](#changelog)
13. [License](#license)

## Features
- **Core Toggle**: Switch between `light`, `dark` and `system` modes effortlessly.
- **Persistence**: Automatically saves user preferences using SharedPreferences.
- **Semantic Tokens**: Define and use colors semantically via type-safe context extensions.
- **Smooth Animations**: Built-in `AnimatedTheme` transitions when switching modes.
- **Widget Switchers**: Swap widgets (`ThemeAsset`, `ThemeIcon`, `ThemeText`, `ThemeLottie`, `ThemeBuilder`) based on the current mode automatically.
- **Preview Mode**: Let users preview a theme before saving it permanently.
- **Named Themes**: Support for infinite custom themes (e.g., "sepia", "high_contrast").
- **Auto Schedule**: Automatically switch modes based on the time of day.
- **No Boilerplate**: Access everything easily via `BuildContext` extensions (`context.isDark`, `context.themeColors`).
- **Debug Overlay**: Built-in overlay to visually debug your active theme tokens.

## Requirements
- Flutter >= 3.10.0
- Dart >= 3.0.0

## Installation
Add the dependency to your `pubspec.yaml`:
```yaml
dependencies:
  themely: ^1.0.0
```

## Getting Started
To get started with Themely, you need to configure your `ThemeController` and wrap your app with `ThemelyApp`. Themely handles the `ThemeData` injection automatically via `AnimatedTheme` for smooth transitions.

## Quick Start

A brief tutorial from zero to running.

1. **Install package**
```yaml
dependencies:
  themely: ^1.0.0
```

2. **Initialize ThemeController in main.dart**
```dart
import 'package:flutter/material.dart';
import 'package:themely/themely.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the controller with your ThemeData
  final controller = ThemeController(
    lightTheme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
  );
  
  // Await initialization to load saved preferences
  await controller.initialize();
  
  runApp(MyApp(controller: controller));
}
```

3. **Wrap MaterialApp with package**
```dart
class MyApp extends StatelessWidget {
  final ThemeController controller;
  
  const MyApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Inject ThemeScope and listen to stream
    return ThemelyApp(
      controller: controller,
      builder: (context, theme, child) => MaterialApp(
        theme: theme,
        home: const Home(),
      ),
    );
  }
}
```

4. **Toggle mode from a button**
```dart
ElevatedButton(
  // Toggles between dark and light mode
  onPressed: () => context.themeController.toggleDark(),
  child: Text(context.isDark ? 'Switch to Light' : 'Switch to Dark'),
)
```

5. **Access color tokens in widgets**
```dart
Container(
  // Automatically adapts based on active mode
  color: context.themeColors.cardSurface, 
)
```

6. **Use a widget switcher**
```dart
// Renders different icons based on mode without manual ternary checks
ThemeIcon(
  light: Icons.wb_sunny,
  dark: Icons.nightlight_round,
)

// Seamlessly switch Lottie animations
ThemeLottie.asset(
  light: 'assets/animations/sun.json',
  dark: 'assets/animations/moon.json',
)
```

7. **Activate scheduled auto switch**
```dart
final controller = ThemeController(
  lightTheme: ThemeData.light(),
  darkTheme: ThemeData.dark(),
  autoSchedule: true, // Enable scheduling
  darkFrom: const TimeOfDay(hour: 18, minute: 0), // Dark starts at 6 PM
  darkUntil: const TimeOfDay(hour: 6, minute: 0), // Dark ends at 6 AM
);
```

## Customization

Themely is built to be extended. Here is how you can customize every aspect of it.

### Custom Color Palette
To define a custom color palette, use `ThemeData` and pass it to the controller.
```dart
final myLightTheme = ThemeData(
  brightness: Brightness.light,
  colorSchemeSeed: Colors.green,
);
```

### Custom Semantic Tokens
You can add your own custom tokens by subclassing `AppThemeTokens` and overriding `lerp`.
```dart
class MyCustomTokens extends AppThemeTokens {
  final Color brandColor;

  const MyCustomTokens({
    required super.buttonBackground,
    // ... other super fields
    required this.brandColor,
  });

  @override
  MyCustomTokens lerp(AppThemeTokens? other, double t) {
    if (other is! MyCustomTokens) return this;
    return MyCustomTokens(
      buttonBackground: Color.lerp(buttonBackground, other.buttonBackground, t)!,
      // ... lerp other super fields
      brandColor: Color.lerp(brandColor, other.brandColor, t)!,
    );
  }
}

// Pass it via ThemeExtension
final theme = ThemeData(
  extensions: [
    AppThemeExtension<MyCustomTokens>(tokens: myTokens),
  ]
);

// Access it
final brand = context.themeTokens<MyCustomTokens>().brandColor;
```

### Per-token Opacity
You can adjust opacity on any token independently using `.withValues(alpha: ...)`.
```dart
Container(
  color: context.themeColors.buttonBackground.withValues(alpha: 0.5),
)
```

### Gradient Support
While tokens natively hold `Color`, you can build gradients using your tokens.
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        context.themeColors.buttonBackground,
        context.themeColors.cardSurface,
      ],
    ),
  ),
)
```

### Custom Font per Mode
Define fonts differently per mode using `ThemeData` or via semantic tokens.
```dart
Text(
  'Hello',
  style: TextStyle(fontFamily: context.themeColors.primaryFont),
)
```

### Custom TextStyle per Mode
You can define entire `TextTheme` per mode in `ThemeData`.
```dart
final lightTheme = ThemeData(
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 0.5),
  ),
);
```

### Custom Border Radius per Mode
Override shapes per mode in `ThemeData`.
```dart
final amoledTheme = ThemeData(
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)), // Sharp edges
  ),
);
```

### Custom Spacing Scale per Mode
Use `ThemeValue` to return different dimensions based on mode.
```dart
Padding(
  padding: EdgeInsets.all(
    context.themeValue<double>(
      light: 16.0,
      dark: 24.0, // More breathing room in dark mode
    )
  ),
  child: const Text('Spaced Content'),
)
```

### Custom Elevation per Mode
```dart
Card(
  elevation: context.themeValue<double>(
    light: 2.0,
    dark: 0.0, // Flat design in dark mode
  ),
)
```

### Custom Overlay & Splash Color
Modify ripple and highlight colors globally in `ThemeData`.
```dart
final theme = ThemeData(
  splashColor: Colors.blue.withValues(alpha: 0.2),
  highlightColor: Colors.transparent,
);
```

### Custom Transition Builder
Customize the cross-fade animation between modes via `ThemeController`.
```dart
final controller = ThemeController(
  animationDuration: const Duration(milliseconds: 500),
  animationCurve: Curves.easeInOutBack,
);
```

### Custom Scheduler Logic
Bypass the built-in `autoSchedule` and trigger mode changes via your own logic (e.g., location, battery level).
```dart
Battery().onBatteryStateChanged.listen((state) {
  if (state == BatteryState.powerSave) {
    context.themeController.setMode(AppThemeMode.amoled);
  }
});
```

### Custom Storage Adapter
Create your own adapter by implementing `ThemeStorage`.
```dart
class HiveThemeStorage implements ThemeStorage {
  @override
  Future<String?> loadMode(String key) async {
    return Hive.box('settings').get(key);
  }

  @override
  Future<void> saveMode(String key, String mode) async {
    await Hive.box('settings').put(key, mode);
  }
}

// Inject it
final controller = ThemeController(storage: HiveThemeStorage());
```

### Custom Persistence Key
If you need to avoid collisions, build a custom adapter that prefixes the keys.
```dart
// Inside your custom storage adapter:
final String prefix = 'my_app_v2_';
await prefs.setString('$prefix$key', mode);
```

### Export/Import Konfigurasi Tema
You can read current active values and serialize them to JSON.
```json
// Example serialized output
{
  "mode": "dark",
  "named": "sepia"
}
```
```dart
final currentMode = context.currentMode.name;
final namedTheme = context.themeController.activeNamedTheme;
final jsonExport = jsonEncode({'mode': currentMode, 'named': namedTheme});
```

### Theme Reset
Clear all named themes and revert to initial configuration.
```dart
await context.themeController.clearNamedTheme();
await context.themeController.setMode(AppThemeMode.system);
```

## API Reference

### `ThemeController`
- `setMode(AppThemeMode mode)`: Sets the global theme mode.
- `toggleDark()`: Toggles between Light and Dark mode.
- `cycleMode()`: Cycles through all available AppThemeModes.
- `registerTheme(String name, {ThemeData? light, ThemeData? dark})`: Registers a new custom named theme.
- `setNamedTheme(String name)`: Activates a registered named theme.
- `clearNamedTheme()`: Reverts to standard mode.
- `preview(AppThemeMode mode)`: Temporarily changes the theme without saving.
- `confirmPreview()`: Saves the currently previewed theme.
- `cancelPreview()`: Reverts to the previously saved theme.
- `modeStream`: `Stream<AppThemeMode>` of mode changes.
- `currentMode`: Returns active `AppThemeMode`.
- `activeNamedTheme`: Returns the active named theme string (nullable).

### `AppThemeMode` (Enum)
- `light`, `dark`, `amoled`, `system`

### `BuildContext` Extensions
- `context.isDark`: `bool`
- `context.isLight`: `bool`
- `context.isAmoled`: `bool`
- `context.currentMode`: `AppThemeMode`
- `context.themeColors`: `AppThemeTokens`
- `context.themeTokens<T>()`: `T extends AppThemeTokens`
- `context.themeController`: `ThemeController`
- `context.themeValue<T>({required T light, T? dark, T? amoled, T? orElse})`: Returns specific value based on mode.

### Widget Switchers
- `ThemeBuilder`: `Widget Function(BuildContext)` for different modes.
- `ThemeAsset`: `ImageProvider` per mode.
- `ThemeIcon`: `IconData` per mode.
- `ThemeText`: `String` per mode.
- `ThemeLottie`: Renders `.json` animations per mode via `lottie` package (`.asset()` or `.network()`).
- `LocalTheme`: Force a subtree to a specific mode.

## Cookbook & FAQ

Here are the most common questions from developers building with Themely.

### 1. How do I change the default colors?
You don't need to rewrite anything. Just use `.copyWith()` on the default tokens when registering your theme.
```dart
final myLightTokens = AppThemeTokens.light.copyWith(
  cardSurface: Colors.white,
  buttonBackground: Colors.blueAccent,
);

// Register it in your ThemeController/ThemeData extensions
```

### 2. How do I add my own color names (e.g., `brandColor`)?
If the default attributes aren't enough, just **extend** the class.
```dart
class MyColors extends AppThemeTokens {
  final Color brandColor;
  const MyColors({required this.brandColor, ...super_fields});
  
  // Override lerp to support animations (see Customization section)
}

// Access it anywhere:
final brand = context.themeTokens<MyColors>().brandColor;
```

### 3. How do I make text color automatic (Contrast Magic)?
Stop guessing if text should be black or white. Use the `contrastOn` helper which automatically picks the best contrast based on WCAG luminance.
```dart
Text(
  'I adapt to my background!',
  style: TextStyle(
    // If buttonBackground is dark, this returns white. If light, returns black.
    color: context.themeColors.contrastOn(context.themeColors.buttonBackground),
  ),
)
```

### 4. How do I make a widget change color automatically?
You have two ways:
- **Stateless/Standard**: Use `context.themeColors.x`. When the theme changes, the widget rebuilds with the new color.
- **Animated**: Use `ThemeAnimatedColor` for a smooth transition.
```dart
ThemeAnimatedColor(
  color: context.themeColors.buttonBackground,
  duration: Duration(milliseconds: 500),
  builder: (context, color, child) => Container(color: color),
)
```

### 5. Can I swap entire widgets based on theme?
Yes! Use our built-in switchers for zero boilerplate:
- `ThemeIcon(light: Icons.sunny, dark: Icons.moon)`
- `ThemeAsset(light: 'day.png', dark: 'night.png')`
- `ThemeText(light: 'Good Morning', dark: 'Good Evening')`

## Contributing

Contributions are welcome! If you find a bug or have a feature request, please open an issue. If you cannot contribute code yet, **giving this repository a ⭐ Star** is also a great way to support the project!

If you want to contribute code, please:

1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Submit a pull request.

## Support

If you find this library useful and want to support its development, you can support me on Ko-fi!

[![Support me on Ko-fi](https://img.shields.io/badge/Support%20me%20on%20Ko-fi-F16061?style=for-the-badge&logo=ko-fi&logoColor=white)](https://ko-fi.com/dimassfeb)

## Contributors

- **Dimas Febriano** ([@dimassfeb-09](https://github.com/dimassfeb-09)) - Creator & Lead Developer
  - Website: [dimassfeb.com](https://dimassfeb.com)

## Changelog
 
 **v1.0.1**
 - Updated README with a centered, responsive preview GIF.
 - Improved documentation layout.


**v1.0.0**
- Initial core release.
- **Core**: Added `ThemeController` with persistence and `AppThemeMode` (light, dark, amoled, system).
- **Architecture**: Implemented `ThemeExtension` with generic support for type-safe custom tokens.
- **Tokens**: Added Semantic Color Tokens, Typography (Font) tokens, and `AppThemeIcons`.
- **UI**: Integrated `AnimatedTheme` for smooth global theme transitions.
- **Widgets**: Introduced `ThemeBuilder`, `ThemeAsset`, `ThemeIcon`, `ThemeText`, and `ThemeLottie`.
- **Logic**: Added `ThemeScheduler` for automatic time-based switching.
- **Tools**: Built-in `DebugThemeOverlay` for visual token debugging.
- **Utilities**: Added `contrastOn` helper for automatic WCAG-compliant text color selection.

## License

MIT License. See LICENSE file for details.
