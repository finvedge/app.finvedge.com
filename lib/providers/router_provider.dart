import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../screens/settings_screen.dart';
import '../screens/home_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          
          return HomeScreen();
        },
        routes: [
          GoRoute(
            path: 'settings',
            builder: (BuildContext context, GoRouterState state) =>
                SettingsScreen(),
          ),
        ],
      ),
    ],
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
