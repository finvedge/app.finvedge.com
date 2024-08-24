import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome back'),
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
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text('Register from website www.finvedge.com'),
              // child: AuthRegisterForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthRegisterForm extends StatefulWidget {
  const AuthRegisterForm({super.key});

  @override
  State<AuthRegisterForm> createState() => _AuthRegisterFormState();
}

class _AuthRegisterFormState extends State<AuthRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _isLoading = false;
  String _name = '';
  String _email = '';
  String _phone = '';
  String _username = '';
  String _password = '';

  final _authController = Get.find<AuthController>();

  final Map<String, dynamic> _registerData = {};
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _registerData['name'] = _name;
      _registerData['email'] = _email;
      _registerData['phone'] = _phone;
      _registerData['username'] = _username;
      _registerData['password'] = _password;
      try {
        await _authController.register(registerData: _registerData);
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
            decoration: const InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please fill your name';
              }
              setState(() {
                _name = value;
              });
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please fill valid username.';
              }
              setState(() {
                _username = value;
              });
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please fill your email address';
              }
              setState(() {
                _email = value;
              });
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please fill your 10 digit phone number';
              }
              setState(() {
                _phone = value;
              });
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Password is required';
              }
              setState(() {
                _password = value;
              });
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isLoading ? null : _register,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              elevation: 4,
            ),
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Create Account', style: TextStyle(fontSize: 18)),
          ),
        ],
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

  final _authController = Get.find<AuthController>();

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
        await _authController.login(loginData: _loginData);
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
              labelText: 'Username or Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().length <= 1) {
                return 'Please fill valid username or email.';
              }
              setState(() {
                _username = value;
              });
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().length <= 1) {
                return 'Password is required';
              }
              setState(() {
                _password = value;
              });
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isLoading ? null : _login,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              elevation: 4,
            ),
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Login', style: TextStyle(fontSize: 18)),
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
