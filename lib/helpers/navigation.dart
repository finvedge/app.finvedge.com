import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Enum to represent the different routing methods
enum NavigationMethod {
  defaultNavigator,
  getX,
}

// Global variable to set the default navigation method
NavigationMethod currentNavigationMethod = NavigationMethod.getX;

// Wrapper function for navigation that accepts either a route name or a widget
void navigateTo(
  BuildContext context, {
  String? routeName,
  Widget? page,
  Object? arguments,
  NavigationMethod? method,
  bool replace = false,
}) {
  final navigationMethod = method ?? currentNavigationMethod;

  if (routeName == null && page == null) {
    throw ArgumentError('Either routeName or page must be provided.');
  }

  switch (navigationMethod) {
    case NavigationMethod.defaultNavigator:
      if (page != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
            settings: RouteSettings(arguments: arguments),
          ),
        );
      } else if (routeName != null) {
        Navigator.pushNamed(
          context,
          routeName,
          arguments: arguments,
        );
      }
      break;

    case NavigationMethod.getX:
      if (page != null) {
        if (replace) {
          Get.off(() => page, arguments: arguments);
        } else {
          Get.to(() => page, arguments: arguments);
        }
      } else if (routeName != null) {
        if (replace) {
          Get.offNamed(routeName, arguments: arguments);
        } else {
          Get.toNamed(routeName, arguments: arguments);
        }
      }
      break;
  }
}
