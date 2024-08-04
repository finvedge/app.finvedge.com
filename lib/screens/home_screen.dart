import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finvedge'),
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('testing'),
            ElevatedButton(
              onPressed: () {
                context.go('/settings');
                // GoRouter.of(context).go('/settings');
              },
              child: Text('test'),
            ),
          ],
        ),
      ),
    );
  }
}
