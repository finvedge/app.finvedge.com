import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

// import 'src/app.dart';
import './helpers/api.dart';
import './providers/theme_provider.dart';
import './providers/router_provider.dart';
// import 'src/controllers/theme_controller.dart';
// import 'src/settings/settings_controller.dart';
// import 'src/settings/settings_service.dart';

// import 'screens/splash_screen.dart';
// import 'screens/home_screen.dart';
// import 'screens/auth_screen.dart';
// import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Api.initializeInterceptors();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  // final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  // await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  // runApp(const MyApp(settingsController: settingsController));
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeProvider);
    final GoRouter goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      locale: const Locale('en'),
      scrollBehavior: MyCustomScrollBehavior(),
      // routerDelegate: goRouter.routerDelegate,
      // routeInformationParser: goRouter.routeInformationParser,
      routerConfig: goRouter,
    );
  }
}
