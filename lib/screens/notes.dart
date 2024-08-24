

  // final _authController = Get.find<AuthController>();

  // Future<void> _singInWithGoogle() async {
  // try {
  //   final user = await GoogleSignInApi.login();
  //   if (user == null) {
  //     if (!context.mounted) return;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Sign in failed')),
  //     );
  //   } else {
  //     if (!context.mounted) return;
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (ctx) => AccountPage(user: user)),
  //     );
  //   }
  // } catch (error) {
  //   if (!context.mounted) return;
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(error.toString())),
  //   );
  // }
  // }




// auth provider

// Future<void> saveFCMToken({required String token}) async {
//     if (state != null) {
//       await Api.saveFCMToken(userId: state!.id, token: token);
//     }
//   }

//   void saveAndroidFCMToken({required String token}) {
//     if (state != null && state!.id.isNotEmpty) {
//       Api.saveAndroidFCMToken(userId: state!.id, token: token);
//     }
//   }

// Future<void> register({
//     required Map<String, dynamic> registerData,
//     required BuildContext context,
//   }) async {
//     final response = await Api.register(registerData: registerData);
//     final userResponse = UserResponse.fromJson(response.data);
//     await storage.write(key: 'auth_token', value: userResponse.token);
//     state = userResponse.user as User?;
//     if (context.mounted) {
//       context.goNamed('settings');
//     }
//   }

// Future<bool> silentLogin() async {
//     final token = await storage.read(key: 'auth_token');
//     if (token != null) {
//       return true;
//     }
//     return false;
//   }


// setState(() {
      //   _isLoading = true;
      // });
      // _loginData['username'] = _username;
      // _loginData['password'] = _password;
      // _loginData['type'] = authType.name;
      // try {
      //   if (authType == AuthenticationType.otp) {
      //     setState(() {
      //       _showOtpInput = true;
      //     });
      //   } else {}

      //   print(_loginData);
      //   setState(() {
      //     _isLoading = false;
      //   });
      // } catch (e) {
      //   setState(() {
      //     _isLoading = false;
      //   });
      // }























