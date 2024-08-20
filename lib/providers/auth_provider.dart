import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import '../src/services/api.dart';
import '../src/responses/user_response.dart';
import '../screens/auth_screen.dart';
import '../screens/home_screen.dart';
import '../screens/account_screen.dart';

// Secure storage instance
final storage = FlutterSecureStorage();

// Auth StateNotifier to manage authentication state
class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null) {
    redirect();
  }

  bool get isLoggedIn => state != null;

  Future<void> redirect() async {
    final token = await storage.read(key: 'auth_token');
    if (token != null) {
      await getUserSilently(token: token);
    }
  }

  Future<bool> silentLogin() async {
    final token = await storage.read(key: 'auth_token');
    print('no token');
    if (token != null) {
      return true;
    }
    return false;
  }

  Future<void> login(
      {required Map<String, dynamic> loginData,
      required BuildContext context}) async {
    final response = await Api.login(loginData: loginData);
    final userResponse = UserResponse.fromJson(response.data);
    await storage.write(key: 'auth_token', value: userResponse.token);
    state = userResponse.user as User?;
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => AccountScreen()));
  }

  Future<void> register(
      {required Map<String, dynamic> registerData,
      required BuildContext context}) async {
    final response = await Api.register(registerData: registerData);
    final userResponse = UserResponse.fromJson(response.data);
    await storage.write(key: 'auth_token', value: userResponse.token);
    state = userResponse.user as User?;
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => AccountScreen()));
  }

  Future<void> logout(BuildContext context) async {
    await storage.delete(key: 'auth_token');
    state = null;
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  Future<void> saveFCMToken({required String token}) async {
    if (state != null) {
      await Api.saveFCMToken(userId: state!.id, token: token);
    }
  }

  void saveAndroidFCMToken({required String token}) {
    if (state != null && state!.id.isNotEmpty) {
      Api.saveAndroidFCMToken(userId: state!.id, token: token);
    }
  }

  Future<void> getUser({required String token}) async {
    final response = await Api.getUser(token: token);
    final userResponse = UserResponse.fromJson(response.data);
    state = userResponse.user as User?;
  }

  Future<void> getUserSilently({required String token}) async {
    final response = await Api.getUserSilently(token: token);
    if (response.isNotEmpty) {
      final userResponse = UserResponse.fromJson(response);
      state = userResponse.user as User?;
    }
  }
}

// Riverpod provider for the AuthController
final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});
