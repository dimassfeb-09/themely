import 'package:flutter/material.dart';
import 'package:themely/themely.dart';
import 'shared/app_themes.dart';
import 'ui/home_screen.dart';
import 'ui/core_toggle_screen.dart';
import 'ui/stream_log_screen.dart';
import 'ui/semantic_tokens_screen.dart';
import 'ui/widget_switcher_screen.dart';
import 'ui/subtree_override_screen.dart';
import 'ui/animation_screen.dart';
import 'ui/preview_mode_screen.dart';
import 'ui/named_theme_screen.dart';
import 'ui/seed_generator_screen.dart';
import 'ui/scheduler_screen.dart';
import 'ui/storage_adapter_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final controller = ThemeController(
    lightTheme: lightTheme,
    darkTheme: darkTheme,
    amoledTheme: amoledTheme,
    initialMode: AppThemeMode.system,
    autoSchedule: false,
    transition: ThemeTransition.fade,
  );
  
  controller.registerTheme('sepia', light: sepiaTheme);
  controller.registerTheme('high_contrast', dark: highContrastTheme);
  
  await controller.initialize();

  runApp(
    ThemelyApp(
      controller: controller,
      builder: (context, theme, child) => DebugThemeOverlay(
        showTokens: false,
        child: MaterialApp(
          title: 'Themely Playground',
          theme: theme,
          home: const MainLayout(),
        ),
      ),
    ),
  );
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<({String title, IconData icon, Widget screen})> _pages = [
    (title: 'Home', icon: Icons.home, screen: const HomeScreen()),
    (title: 'Core Toggle', icon: Icons.toggle_on, screen: const CoreToggleScreen()),
    (title: 'Stream Log', icon: Icons.list_alt, screen: const StreamLogScreen()),
    (title: 'Tokens', icon: Icons.color_lens, screen: const SemanticTokensScreen()),
    (title: 'Switchers', icon: Icons.widgets, screen: const WidgetSwitcherScreen()),
    (title: 'Local Override', icon: Icons.picture_in_picture, screen: const SubtreeOverrideScreen()),
    (title: 'Animations', icon: Icons.animation, screen: const AnimationScreen()),
    (title: 'Preview Mode', icon: Icons.preview, screen: const PreviewModeScreen()),
    (title: 'Named Themes', icon: Icons.palette, screen: const NamedThemeScreen()),
    (title: 'Seed Gen', icon: Icons.colorize, screen: const SeedGeneratorScreen()),
    (title: 'Scheduler', icon: Icons.schedule, screen: const SchedulerScreen()),
    (title: 'Storage', icon: Icons.storage, screen: const StorageAdapterScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_currentIndex].title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: context.themeColors.buttonBackground,
              ),
              child: Text(
                'Themely Playground',
                style: TextStyle(
                  color: context.themeColors.contrastOn(context.themeColors.buttonBackground),
                  fontSize: 24,
                ),
              ),
            ),
            ...List.generate(_pages.length, (index) {
              return ListTile(
                leading: Icon(_pages[index].icon),
                title: Text(_pages[index].title),
                selected: _currentIndex == index,
                onTap: () {
                  setState(() => _currentIndex = index);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
      body: _pages[_currentIndex].screen,
    );
  }
}
