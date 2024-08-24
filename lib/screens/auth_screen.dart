import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

enum AuthenticationType { otp, password }

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Login'),
              Tab(text: 'Register'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: AuthLoginForm(),
            ),
            const SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Visit finvedge.com website to register'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final responseMessageProvider = StateProvider<String>((ref) => '');
final passwordVisibleProvider = StateProvider<bool>((ref) => false);
final isLoadingProvider = StateProvider<bool>((ref) => false);
final usernameProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final showOtpInputProvider = StateProvider<bool>((ref) => false);
final authTypeProvider =
    StateProvider<AuthenticationType>((ref) => AuthenticationType.otp);

class AuthLoginForm extends ConsumerWidget {
  AuthLoginForm({super.key});

  final formKey = GlobalKey<FormState>();
  // final isLoggedIn = await ref.read(authProvider.notifier).silentLogin();

  Future<void> _login(BuildContext context, WidgetRef ref) async {
    if (formKey.currentState!.validate()) {
      final auth = ref.watch(authProvider.notifier);
      final username = ref.watch(usernameProvider);
      final password = ref.watch(passwordProvider);
      final authType = ref.watch(authTypeProvider);

      Map<String, dynamic> loginData = {
        'username': username,
        'password': password,
        'type': authType.name,
      };

      try {
        ref.read(isLoadingProvider.notifier).update((state) => true);
        ref.read(responseMessageProvider.notifier).update((state) => '');

        if (authType == AuthenticationType.otp) {
          ref.read(showOtpInputProvider.notifier).update((state) => true);
        } else {
          final response =
              await auth.login(loginData: loginData, context: context);
          final data = json.decode(response.toString());
          final message = data['message'] ?? '';
          if (context.mounted && !message.isEmpty) {
            ref
                .read(responseMessageProvider.notifier)
                .update((state) => message);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data['message'])),
            );
          }
        }
      } catch (error) {
        if (context.mounted) {
          ref
              .read(responseMessageProvider.notifier)
              .update((state) => error.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
            ),
          );
        }
        ref.read(isLoadingProvider.notifier).update((state) => false);
      } finally {
        ref.read(isLoadingProvider.notifier).update((state) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordVisible = ref.watch(passwordVisibleProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final showOtpInput = ref.watch(showOtpInputProvider);
    final authType = ref.watch(authTypeProvider);
    final responseMessage = ref.watch(responseMessageProvider);

    return Form(
      key: formKey,
      child: Column(
        children: [
          if (showOtpInput)
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter OTP sent to your email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1) {
                  return 'Please enter OTP';
                }
                return null;
              },
            ),
          if (!showOtpInput)
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email or Phone number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1) {
                  return 'Please fill valid email or phone number';
                }
                ref.read(usernameProvider.notifier).update((state) => value);
                return null;
              },
            ),
          if (authType == AuthenticationType.password)
            const SizedBox(height: 20),
          if (authType == AuthenticationType.password)
            TextFormField(
              obscureText: !passwordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    ref
                        .read(passwordVisibleProvider.notifier)
                        .update((state) => !state);
                  },
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1) {
                  return 'Password is required';
                }
                ref.read(passwordProvider.notifier).update((state) => value);
                return null;
              },
            ),
          const SizedBox(height: 20),
          if (responseMessage.isNotEmpty) Text(responseMessage),
          if (responseMessage.isNotEmpty) const SizedBox(height: 16),
          ElevatedButton(
            onPressed: isLoading ? null : () => _login(context, ref),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              elevation: 3,
            ),
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(
                    authType == AuthenticationType.otp
                        ? 'Login with OTP'
                        : 'Login with Password',
                    style: const TextStyle(fontSize: 18),
                  ),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('OR'),
              ),
              Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          showOtpInput
              ? TextButton(
                  onPressed: () {
                    ref
                        .read(showOtpInputProvider.notifier)
                        .update((state) => false);
                  },
                  child: const Text('Change Email/Phone for OTP'),
                )
              : ElevatedButton(
                  onPressed: () {
                    ref.read(authTypeProvider.notifier).update((state) {
                      if (authType == AuthenticationType.otp) {
                        return AuthenticationType.password;
                      } else {
                        return AuthenticationType.otp;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                    elevation: 3,
                  ),
                  child: Text(
                    authType == AuthenticationType.otp
                        ? 'Login with Password'
                        : 'Login with OTP',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
        ],
      ),
    );
  }
}
