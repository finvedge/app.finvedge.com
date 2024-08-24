import 'package:flutter/material.dart';

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
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            SizedBox(height: 16),
            Text(
              'Under active development',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
