import 'package:finvedge/src/screens/policies_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../screens/notes_screen.dart';
import '../screens/account_screen.dart';
import '../screens/auth_screen.dart';
// import '../screens/categories_screen.dart';
// import '../screens/shop_screen.dart';
import '../controllers/auth_controller.dart';

class MyBottomAppBar extends StatelessWidget {
  MyBottomAppBar({super.key});

  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 65.0,
      padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            onPressed: () {
              // Get.to(() => ShopScreen(), preventDuplicates: true);
            },
            iconSize: 30.0,
            tooltip: 'Shop',
            icon: const Icon(Icons.storefront),
          ),
          IconButton(
            onPressed: () {
              // Get.to(() => CategoriesScreen(), preventDuplicates: true);
            },
            iconSize: 30.0,
            tooltip: 'Categories',
            icon: const Icon(Icons.category),
          ),
          const SizedBox(width: 10),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              // if (_authController.isLoggedIn.value) {
              // Get.to(
              //   () => NotesScreen(),
              //   preventDuplicates: true,
              // );
              // } else {
              Get.to(
                () => PoliciesScreen(),
                preventDuplicates: true,
              );
              // }
            },
            iconSize: 30.0,
            tooltip: 'Policies',
            icon: const Icon(Icons.sticky_note_2_sharp),
          ),
          IconButton(
            onPressed: () {
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
            iconSize: 30.0,
            tooltip: 'Account',
            icon: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
