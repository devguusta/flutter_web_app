import 'package:flutter/material.dart';
import 'package:flutter_web_app/core/routes/routes.dart';
import 'package:flutter_web_app/features/authentication/presentation/login/page/login_page.dart';
import 'package:flutter_web_app/features/authentication/presentation/splash/page/splash_page.dart';

/// This class is responsible for defining the routes of the application.
/// It contains a static method that returns a map of route names to their corresponding widget builders.
/// The routes are defined in the `Routes` class.
/// This class is used in the `main.dart` file to set up the routes for the `MaterialApp`.
sealed class RoutesMap {
  static Map<String, WidgetBuilder> get routes => {
        "/": (context) => SplashPage(),
        Routes.home: (context) => const Placeholder(),
        Routes.login: (context) => const LoginPage(),
      };
}
