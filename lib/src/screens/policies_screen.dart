import 'package:flutter/material.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Policies'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.notes_rounded),
              title: const Text('Policy name'),
              subtitle: const Text('some text'),
              trailing: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.access_alarm_rounded),
                  Text('sdlfkj'),
                ],
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
