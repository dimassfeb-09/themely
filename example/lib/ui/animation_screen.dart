import 'package:flutter/material.dart';
import 'package:themely/themely.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  // We can't change the controller's duration/curve after initialization directly
  // through its public API in this simple implementation, so we will just
  // trigger mode changes to show the current animation configuration.
  // Ideally, ThemeController would have setters for duration/curve/transition if
  // they need to be changed at runtime. Since they are final in our controller,
  // we will just demonstrate the transition that was configured in main.dart.
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Animations are configured when ThemeController is initialized.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Current Configuration:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Duration: ${context.themeController.animationDuration.inMilliseconds}ms'),
                Text('Transition: ${context.themeController.transition.name}'),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 32),
        ElevatedButton.icon(
          icon: const Icon(Icons.animation),
          label: const Text('Trigger Mode Change to see Animation'),
          onPressed: () => context.themeController.cycleMode(),
        ),
        
        const SizedBox(height: 48),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: context.themeColors.cardSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.themeColors.dividerColor, width: 2),
            image: const DecorationImage(
              image: NetworkImage('https://picsum.photos/400/200'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: ThemeBuilder(
              light: (_) => const Text('Light Image Filter', style: TextStyle(color: Colors.white, fontSize: 24, shadows: [Shadow(color: Colors.black, blurRadius: 4)])),
              dark: (_) => const Text('Dark Image Filter', style: TextStyle(color: Colors.black, fontSize: 24, shadows: [Shadow(color: Colors.white, blurRadius: 4)])),
            ),
          ),
        ),
      ],
    );
  }
}
