import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType { system, light, dark }

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier({ref}) : super(ThemeMode.system) {
    SharedPreferences.getInstance().then((prefs) {
      _loadTheme();
    });
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('theme') ?? 'system';
    state = _getThemeMode(themeName);
  }

  void setTheme(ThemeType themeType) async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = themeType.toString().split('.').last;
    await prefs.setString('theme', themeName);
    state = _getThemeMode(themeName);
  }

  ThemeMode _getThemeMode(String themeName) {
    switch (themeName) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String get currentThemeName {
    switch (state) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      default:
        return 'System';
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
