import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherly/core/app_theme.dart';

// Theme StateNotifier
class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(_getSystemTheme());

  static ThemeData _getSystemTheme() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    return brightness == Brightness.light ? lightTheme : darkTheme;
  }

  void toggleTheme() {
    state = state.brightness == Brightness.light ? darkTheme : lightTheme;
  }
}

// Create a provider for the theme
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>(
  (ref) => ThemeNotifier(),
);
