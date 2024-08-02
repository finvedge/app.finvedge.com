import 'package:get/get.dart';

import '../screens/home_screen.dart';
import '../screens/account_screen.dart';
// import '../screens/notes_screen.dart';

class WelcomeController extends GetxController {
  var currentIndex = 1.obs;
  var screens = [
    HomeScreen(),
    // NotesScreen(),
    AccountScreen(),
    AccountScreen(),
  ];
}
