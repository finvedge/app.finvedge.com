import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// final Uri _url = Uri.parse('https://flutter.dev'); 

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  // Future<void> _launchUrl() async {
  //   if (!await launchUrl(_url)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }

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
        body: const TabBarView(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: AuthLoginForm(),
            ),
            SingleChildScrollView(
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

class AuthLoginForm extends StatefulWidget {
  const AuthLoginForm({super.key});

  @override
  State<AuthLoginForm> createState() => _AuthLoginFormState();
}

class _AuthLoginFormState extends State<AuthLoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _isLoading = false;
  String _username = '';
  String _password = '';

  // final _authController = Get.find<AuthController>();

  Future<void> _singInWithGoogle() async {
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
  }

  // ignore: prefer_final_fields
  Map<String, dynamic> _loginData = {};
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _loginData['username'] = _username;
      _loginData['password'] = _password;
      try {
        // await _authController.login(loginData: _loginData);
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email or Phone number',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().length <= 1) {
                return 'Please fill valid email or phone number';
              }
              setState(() {
                _username = value;
              });
              return null;
            },
          ),
          // const SizedBox(height: 20),
          // TextFormField(
          //   obscureText: !_passwordVisible,
          //   decoration: InputDecoration(
          //     labelText: 'Password',
          //     border: const OutlineInputBorder(),
          //     suffixIcon: IconButton(
          //       onPressed: () {
          //         setState(() {
          //           _passwordVisible = !_passwordVisible;
          //         });
          //       },
          //       icon: Icon(
          //           _passwordVisible ? Icons.visibility : Icons.visibility_off),
          //     ),
          //   ),
          //   validator: (value) {
          //     if (value == null || value.isEmpty || value.trim().length <= 1) {
          //       return 'Password is required';
          //     }
          //     setState(() {
          //       _password = value;
          //     });
          //     return null;
          //   },
          // ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isLoading ? null : _login,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              elevation: 4,
            ),
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Send OTP', style: TextStyle(fontSize: 18)),
          ),
          // const SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: _isLoading ? null : _singInWithGoogle,
          //   style: ElevatedButton.styleFrom(
          //     minimumSize: const Size.fromHeight(54),
          //     elevation: 4,
          //   ),
          //   child: const Text(
          //     'Continue with Google',
          //     style: TextStyle(fontSize: 18),
          //   ),
          // ),
        ],
      ),
    );
  }
}
