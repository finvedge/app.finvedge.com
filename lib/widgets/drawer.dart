import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // UserAccountsDrawerHeader(
          //   accountName: Text(
          //       _authController.isLoggedIn.value ? _authController.user.value.name : 'Welcome Guest'),
          //   accountEmail: Text(
          //       _authController.isLoggedIn.value ? _authController.user.value.email : ''),
          //   currentAccountPicture: CircleAvatar(
          //     backgroundImage: NetworkImage(_authController.isLoggedIn.value
          //         ? _authController.user.value.image
          //         : 'https://dummyimage.com/300&text=+'),
          //   ),
          //   decoration: const BoxDecoration(
          //     color: Colors.black,
          //     image: DecorationImage(
          //       image: AssetImage('assets/images/drawer_header.jpg'),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          //   // otherAccountsPictures: [
          //   //   CircleAvatar(
          //   //     backgroundColor: Colors.white,
          //   //     backgroundImage: NetworkImage('https://dummyimage.com/90'),
          //   //   )
          //   // ],
          // ),
          ListTile(
            title: const Text('Credit Card Leads'),
            leading: const Icon(Icons.sticky_note_2_sharp),
            onTap: () {
              Navigator.pop(context);
              // Get.to(
              //   () => NotesScreen(),
              //   preventDuplicates: true,
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              context.go('/settings');
              // Get.to(
              //   () => SettingsScreen(),
              //   preventDuplicates: true,
              // );
            },
          ),
          ListTile(
            title: const Text('My Account'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.pop(context);
              // if (_authController.isLoggedIn.value) {
              //   Get.to(
              //     () => AccountScreen(),
              //     preventDuplicates: true,
              //   );
              // } else {
              //   // Get.to(
              //   //   () => AuthScreen(),
              //   //   preventDuplicates: true,
              //   // );
              // }
            },
          ),
        ],
      ),
    );
  }
}
