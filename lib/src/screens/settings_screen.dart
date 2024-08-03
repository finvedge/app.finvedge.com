import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final ThemeController themeController = Get.find();

  void _showThemeSelectionSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 16, bottom: 32),
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
              groupValue: themeController.themeType,
              onChanged: (ThemeType? value) {
                if (value != null) {
                  themeController.setTheme(value);
                  Get.back(); // Close the bottom sheet
                }
              },
            );
          }).toList(),
        ),
      ),
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              subtitle: Text(themeController.currentThemeName),
              onTap: () {
                _showThemeSelectionSheet(context);
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
}
