// import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';
import '../controllers/base_controller.dart';
import '../screens/welcome_screen.dart';
// import '../controllers/note_controller.dart';
// import '../api/google_signin_api.dart';
// import '../services/firebase_api.dart';

class AuthController extends GetxController with BaseController {
  var isLoggedIn = false.obs;
  var user = User().obs;
  // var noteController = Get.put(NoteController());

  @override
  void onInit() {
    redirect();
    // noteController.getNotes();
    super.onInit();
  }

  Future<void> redirect() async {
    var token = await GetStorage().read('auth_token');
    if (token != null) {
      await getUserSilently(token: token);
    }
    // await Future<void>.delayed(const Duration(seconds: 1));
    Get.off(() => WelcomeScreen());
  }

  Future<void> login({required Map<String, dynamic> loginData}) async {
    // var response = await Api.login(loginData: loginData);
    // var userResponse = UserResponse.fromJson(response.data);
    // await GetStorage().write('auth_token', userResponse.token);
    // user.value = userResponse.user;
    // isLoggedIn.value = true;
    // // await requestAndroidFCMToken();
    // Get.off(() => AccountScreen());
  }

  Future<void> register({required Map<String, dynamic> registerData}) async {
    // var response = await Api.register(registerData: registerData);
    // var userResponse = UserResponse.fromJson(response.data);
    // await GetStorage().write('auth_token', userResponse.token);
    // user.value = userResponse.user;
    // isLoggedIn.value = true;
    // // await requestAndroidFCMToken();
    // Get.off(() => AccountScreen());
  }

  Future<void> logout() async {
    await GetStorage().remove('auth_token');
    isLoggedIn.value = false;
    Get.off(() => WelcomeScreen());
  }

  Future<void> saveFCMToken({required String token}) async {
    // await Api.saveFCMToken(userId: user.value.id, token: token);
  }

  // Future<void> requestAndroidFCMToken() async {
  //   if(!kIsWeb){
  //     await FirebaseApi().initNotifications();
  //   }
  // }

  void saveAndroidFCMToken({
    required String token,
  }) {
    if(user.value.id.isNotEmpty){
      // Api.saveAndroidFCMToken(userId: user.value.id, token: token);
    }
  }

  Future<void> getUser({required String token}) async {
    // var response = await Api.getUser(token: token);
    // var userResponse = UserResponse.fromJson(response.data);
    // user.value = userResponse.user;
    // isLoggedIn.value = true;
  }

  Future<void> getUserSilently({required String token}) async {
    // var response = await Api.getUserSilently(token: token);
    // if(response.isNotEmpty){
    //   var userResponse = UserResponse.fromJson(response);
    //   user.value = userResponse.user;
    //   isLoggedIn.value = true;
    // }
  }

  // Future<void> loginWithGoogle() async {
  //   await GoogleSignInApi.login();
  // }
}
