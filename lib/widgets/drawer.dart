import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:finvedge/providers/auth_provider.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
  
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(auth?.name ?? 'Welcome Guest'),
            accountEmail: Text(auth?.email ?? ''),
            // currentAccountPicture: CircleAvatar(
            //   backgroundImage: NetworkImage('https://dummyimage.com/300&text=+'),
            // ),
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage('assets/images/drawer_header.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            //   // otherAccountsPictures: [
            //   //   CircleAvatar(
            //   //     backgroundColor: Colors.white,
            //   //     backgroundImage: NetworkImage('https://dummyimage.com/90'),
            //   //   )
            //   // ],
          ),
          ListTile(
            title: const Text('Members'),
            leading: const Icon(Icons.group_rounded),
            onTap: () {
              Navigator.pop(context);
              context.goNamed('credit-card-leads');
            },
          ),
          ListTile(
            title: const Text('Credit Card Leads'),
            leading: const Icon(Icons.credit_card_rounded),
            onTap: () {
              Navigator.pop(context);
              context.goNamed('credit-card-leads');
            },
          ),
          ListTile(
            title: const Text('My Account'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.pop(context);
              context.goNamed('auth');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              context.goNamed('settings');
            },
          ),
          
        ],
      ),
    );
  }
}
