import 'package:flutter/material.dart';

class CreditCardLeadsScreen extends StatelessWidget {
  const CreditCardLeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Card Leads'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Under active development'),
              onTap: () {
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
