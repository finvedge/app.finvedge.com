import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/welcome_controller.dart';
import '../controllers/auth_controller.dart';
// import '../screens/notes_screen.dart';
import '../screens/account_screen.dart';
import '../screens/auth_screen.dart';
import '../screens/settings_screen.dart';
import '../widgets/my_bottom_app_bar.dart';

import '../services/api.dart';

import '../constants.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final welcomeController = Get.put(WelcomeController());
  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Finvedge'),
        ),
        body: const SingleChildScrollView(
          child: Center(child: Text('')),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                    _authController.isLoggedIn.value ? _authController.user.value.name : 'Welcome Guest'),
                accountEmail: Text(
                    _authController.isLoggedIn.value ? _authController.user.value.email : ''),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(_authController.isLoggedIn.value
                      ? _authController.user.value.image
                      : 'https://dummyimage.com/300&text=+'),
                ),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage('assets/images/drawer_header.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                // otherAccountsPictures: [
                //   CircleAvatar(
                //     backgroundColor: Colors.white,
                //     backgroundImage: NetworkImage('https://dummyimage.com/90'),
                //   )
                // ],
              ),
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
                  Get.to(
                    () => SettingsScreen(),
                    preventDuplicates: true,
                  );
                },
              ),
              ListTile(
                title: const Text('My Account'),
                leading: const Icon(Icons.person),
                onTap: () {
                  Navigator.pop(context);
                  if (_authController.isLoggedIn.value) {
                    Get.to(
                      () => AccountScreen(),
                      preventDuplicates: true,
                    );
                  } else {
                    Get.to(
                      () => AuthScreen(),
                      preventDuplicates: true,
                    );
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomAppBar(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          shape: const CircleBorder(),
          tooltip: 'Cart',
          child: const Icon(Icons.shopping_cart),
        ),
      );
    });
  }
}
