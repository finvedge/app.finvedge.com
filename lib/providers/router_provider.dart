import 'package:finvedge/screens/credit_card_leads_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../screens/settings_screen.dart';
import '../screens/home_screen.dart';
import '../screens/error_404_screen.dart';
import '../screens/auth_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  String? redirect(BuildContext context) {
    return null;
  }
  
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return HomeScreen();
        },
        routes: [
          GoRoute(
            path: 'settings',
            name: 'settings',
            builder: (context, state) =>
                const SettingsScreen(),
          ),
          GoRoute(
            path: 'auth',
            name: 'auth',
            redirect: (context, state) => redirect(context),
            builder: (context, state) {
              return const AuthScreen();
            },
          ),
          GoRoute(
            path: 'credit-card-leads',
            name: 'credit-card-leads',
            redirect: (context, state) => redirect(context),
            builder: (context, state) {
              return const CreditCardLeadsScreen();
            },
          ),
        ],
      ),
    ],
    errorBuilder: (BuildContext context, GoRouterState state) => const Error404Screen(),
    // redirect: (context, state) async {
    //   final prefs = await SharedPreferences.getInstance();
    //   final lastLocation = prefs.getString('lastLocation') ?? '/';
    //   if (state.location == '/') {
    //     return lastLocation;
    //   }
    //   return null;
    // },
    // navigatorBuilder: (context, state, child) {
    //   return WillPopScope(
    //     onWillPop: () async {
    //       final prefs = await SharedPreferences.getInstance();
    //       prefs.setString('lastLocation', state.location);
    //       return true;
    //     },
    //     child: child,
    //   );
    // },
  );
});
