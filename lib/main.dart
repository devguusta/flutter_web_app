import 'package:flutter/material.dart';
import 'package:flutter_web_app/core/routes/routes_map.dart';
import 'package:flutter_web_app/core/setup/core_setup.dart';
import 'package:flutter_web_app/core/theme/theme.dart';
import 'package:flutter_web_app/features/authentication/setup/authentication_setup.dart';

void main() {
  CoreSetup.setup();
  AuthenticationSetup.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open weather web-app',
      theme: CustomTheme.themeData,
      routes: RoutesMap.routes,
    );
  }
}
