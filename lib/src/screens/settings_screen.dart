import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // SwitchListTile(
            //   value: true,
            //   onChanged: (isChecked) {},
            //   title: const Text(''),
            //   subtitle: const Text('Only included gluten free meals'),
            // ),
            Center(child: Text('Settings Page'))
          ],
        ),
      ),
    );
  }
}
