import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum ThemeType { system, light, dark }

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'themeMode';

  ThemeType get themeType {
    String storedTheme = _box.read(_key) ?? 'system';
    return ThemeType.values.firstWhere((e) => e.toString() == storedTheme,
        orElse: () => ThemeType.system);
  }

  String get currentThemeName {
    switch (themeType) {
      case ThemeType.light:
        return 'Light';
      case ThemeType.dark:
        return 'Dark';
      default:
        return 'System';
    }
  }

  ThemeMode get theme {
    switch (themeType) {
      case ThemeType.light:
        return ThemeMode.light;
      case ThemeType.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void setTheme(ThemeType themeType) {
    Get.changeThemeMode(_getThemeMode(themeType));
    _box.write(_key, themeType.toString());
  }

  ThemeMode _getThemeMode(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.light:
        return ThemeMode.light;
      case ThemeType.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
