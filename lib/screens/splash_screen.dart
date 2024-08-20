import 'dart:async';

import 'package:finvedge/helpers/navigation.dart';
import 'package:finvedge/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // always navigate to home
    Future<void> checkUser() async {
      final isLoggedIn = await ref.read(authProvider.notifier).silentLogin();
      if (context.mounted) {
        navigateTo(context, routeName: '/home', replace: true);
      }
    }

    checkUser();

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Loading...')
          ],
        ),
      ),
    );
  }
}
