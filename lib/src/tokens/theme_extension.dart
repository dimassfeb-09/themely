import 'package:flutter/material.dart';
import 'app_theme_tokens.dart';

class AppThemeExtension<T extends AppThemeTokens> extends ThemeExtension<AppThemeExtension<T>> {
  const AppThemeExtension({required this.tokens});

  final T tokens;

  @override
  AppThemeExtension<T> copyWith({T? tokens}) {
    return AppThemeExtension<T>(
      tokens: tokens ?? this.tokens,
    );
  }

  @override
  AppThemeExtension<T> lerp(ThemeExtension<AppThemeExtension<T>>? other, double t) {
    if (other is! AppThemeExtension<T>) {
      return this;
    }

    return AppThemeExtension<T>(
      tokens: tokens.lerp(other.tokens, t) as T,
    );
  }

  /// Shorthand to access the extension from BuildContext
  static AppThemeExtension<T> of<T extends AppThemeTokens>(BuildContext context) {
    final extension = Theme.of(context).extension<AppThemeExtension<T>>();
    if (extension != null) return extension;
    
    // Fallback if generic type is not found, try to get the base one
    final baseExtension = Theme.of(context).extension<AppThemeExtension<AppThemeTokens>>();
    if (baseExtension != null) return baseExtension as AppThemeExtension<T>;

    throw FlutterError(
      '[themely] AppThemeExtension<$T> not found in ThemeData. '
      'Ensure you registered it in ThemeData.extensions.',
    );
  }
}
