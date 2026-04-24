import 'package:flutter/material.dart';

import '../extensions/build_context_ext.dart';

class DebugThemeOverlay extends StatelessWidget {
  const DebugThemeOverlay({
    super.key,
    required this.child,
    this.alignment = Alignment.bottomRight,
    this.showTokens = true,
    this.showWarnings = true,
  });

  final Widget child;
  final Alignment alignment;
  final bool showTokens;
  final bool showWarnings;

  @override
  Widget build(BuildContext context) {
    // Only show in debug mode
    bool isDebug = false;
    assert(() {
      isDebug = true;
      return true;
    }());

    if (!isDebug) return child;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          child,
          Positioned(
            bottom: alignment == Alignment.bottomRight || alignment == Alignment.bottomLeft ? 16 : null,
            top: alignment == Alignment.topRight || alignment == Alignment.topLeft ? 16 : null,
            right: alignment == Alignment.bottomRight || alignment == Alignment.topRight ? 16 : null,
            left: alignment == Alignment.bottomLeft || alignment == Alignment.topLeft ? 16 : null,
            child: const _DebugPanel(),
          ),
        ],
      ),
    );
  }
}

class _DebugPanel extends StatelessWidget {
  const _DebugPanel();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Material(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (context) {
              try {
                final mode = context.currentMode;
                final named = context.themeController.activeNamedTheme;
                
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mode: ${mode.name}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    if (named != null)
                      Text(
                        'Named: $named',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                  ],
                );
              } catch (_) {
                return const Text(
                  'ThemeController not found',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
