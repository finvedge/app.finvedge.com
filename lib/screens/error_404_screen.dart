import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Error404Screen extends StatelessWidget {
  const Error404Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const Text('This page does not exist'),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Back to Home'),
                onPressed: () {
                  context.goNamed('home');
                },
              )
              // SwitchListTile(
              //   value: true,
              //   onChanged: (isChecked) {},
              //   title: const Text(''),
              //   subtitle: const Text('Only included gluten free meals'),
              // ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
