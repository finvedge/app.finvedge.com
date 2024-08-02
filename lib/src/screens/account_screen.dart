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
