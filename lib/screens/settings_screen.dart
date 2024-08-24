import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final themeNotifier = ref.watch(themeProvider.notifier);

    void showThemeSelectionSheet(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.only(top: 32, bottom: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: ThemeType.values.map((ThemeType type) {
                  return RadioListTile<ThemeType>(
                    title: Text(
                      type == ThemeType.system
                          ? 'System'
                          : type == ThemeType.light
                              ? 'Light'
                              : 'Dark',
                    ),
                    value: type,
                    groupValue: _themeTypeFromMode(themeMode),
                    onChanged: (ThemeType? value) {
                      if (value != null) {
                        themeNotifier.setTheme(value);
                        Navigator.pop(context);
                      }
                    },
                  );
                }).toList(),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.brightness_6_rounded),
              title: const Text('Choose Theme'),
              subtitle: Text(themeNotifier.currentThemeName),
              onTap: () {
                showThemeSelectionSheet(context);
              },
            ),
            // SwitchListTile(
            //   value: true,
            //   onChanged: (isChecked) {},
            //   title: const Text(''),
            //   subtitle: const Text('Only included gluten free meals'),
            // ),
          ],
        ),
      ),
    );
  }

  ThemeType _themeTypeFromMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return ThemeType.light;
      case ThemeMode.dark:
        return ThemeType.dark;
      default:
        return ThemeType.system;
    }
  }
}
