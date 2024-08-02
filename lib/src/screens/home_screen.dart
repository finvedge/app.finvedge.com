import 'package:flutter/material.dart';

import '../widgets/my_bottom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const SingleChildScrollView(
        child: Text('Home Page'),
      ),
    );
  }
}
