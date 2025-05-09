import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_app/core/getit/getit_instance.dart';
import 'package:flutter_web_app/core/routes/routes_map.dart';
import 'package:flutter_web_app/core/setup/core_setup.dart';
import 'package:flutter_web_app/core/theme/theme.dart';
import 'package:flutter_web_app/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:flutter_web_app/features/authentication/setup/authentication_setup.dart';
import 'package:flutter_web_app/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:flutter_web_app/features/weather/setup/weather_setup.dart';
import 'package:flutter_web_app/firebase_options.dart';
import 'package:geolocator/geolocator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CoreSetup.setup();
  AuthenticationSetup.setup();
  WeatherSetup.setup();
  Geolocator.requestPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => getIt.get<LoginCubit>(),
        ),
        BlocProvider<WeatherCubit>(
          create: (context) => getIt.get<WeatherCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Open weather web-app',
        theme: CustomTheme.themeData,
        routes: RoutesMap.routes,
      ),
    );
  }
}
