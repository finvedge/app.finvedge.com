import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../models/user.dart';
import '../helpers/api.dart';
import '../responses/user_response.dart';

const storage = FlutterSecureStorage();

// A StateNotifier to manage the loading state
class IsUserLoadingNotifier extends StateNotifier<bool> {
  IsUserLoadingNotifier() : super(false);

  void setLoading(bool isLoading) {
    state = isLoading;
  }
}

final isUserLoadingProvider =
    StateNotifierProvider<IsUserLoadingNotifier, bool>((ref) {
  return IsUserLoadingNotifier();
});

// Auth StateNotifier to manage authentication state
class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier(this.ref) : super(null) {
    redirect();
  }

  final Ref ref;
  bool get isLoggedIn => state != null;

  Future<void> redirect() async {
    await silentLogin();
  }

  Future<dynamic> login({
    required Map<String, dynamic> loginData,
    required BuildContext context,
  }) async {
    final response = await Api.login(loginData: loginData);
    if (response.statusCode == 200) {
      final userResponse = UserResponse.fromJson(response.data);
      await storage.write(key: 'authToken', value: userResponse.token);
      state = userResponse.user as User?;
      if (context.mounted) {
        context.goNamed('settings');
      }
    }
    return response;
  }

  Future<void> silentLogin() async {
    if (state == null) {
      final token = await storage.read(key: 'authToken');
      if (token != null) {
        // @TODO track user loading and prevent double calls
        final response = await Api.getUserSilently(token: token);
        if (response.statusCode == 200) {
          final userResponse = UserResponse.fromJson(response.data);
          state = userResponse.user as User?;
        }
      }
    }
  }

  // Future<void> getUserSilently({required String token}) async {
  //   final response = await Api.getUserSilently(token: token);
  //   if (response.statusCode == 200) {
  //     final userResponse = UserResponse.fromJson(response.data);
  //     state = userResponse.user as User?;
  //   }
  // }

  Future<void> logout(BuildContext context) async {
    await storage.delete(key: 'authToken');
    state = null;
    if (context.mounted) {
      context.goNamed('settings');
    }
  }

  Future<void> getUser({required String token}) async {
    // final response = await Api.getUser(token: token);
    // final userResponse = UserResponse.fromJson(response.data);
    // state = userResponse.user as User?;
  }
}

// Riverpod provider for the AuthController
final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier(ref);
});
