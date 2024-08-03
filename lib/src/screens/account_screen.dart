import 'dart:convert';

import '../controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../services/firebase_api.dart';
import 'settings_screen.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => SettingsScreen());
            },
            icon: const Icon(Icons.settings),
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              print(value); // Handle menu item selection
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Option 1',
                  child: Text('Option 1'),
                ),
                const PopupMenuItem<String>(
                  value: 'Option 2',
                  child: Text('Option 2 is long text k'),
                ),
                const PopupMenuItem<String>(
                  value: 'Option 3',
                  child: Text('Option 3'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(width: 10),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _authController.logout();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
