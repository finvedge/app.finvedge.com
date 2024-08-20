import 'package:finvedge/helpers/navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Welcome Guest'),
            accountEmail: Text(''),
            // currentAccountPicture: CircleAvatar(
            //   backgroundImage: NetworkImage('https://dummyimage.com/300&text=+'),
            // ),
            decoration: BoxDecoration(
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
            title: const Text('Credit Card Leads'),
            leading: const Icon(Icons.sticky_note_2_sharp),
            onTap: () {
              Navigator.pop(context);
              context.goNamed('credit-card-leads');
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
          ListTile(
            title: const Text('My Account'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.pop(context);
              context.goNamed('auth');
            },
          ),
        ],
      ),
    );
  }
}
