import 'package:dio/dio.dart';
import 'package:flutter_web_app/core/getit/getit_instance.dart';
import 'package:flutter_web_app/core/http/http_client.dart';
import 'package:flutter_web_app/core/http/http_client_implementation.dart';

/// This class is responsible for setting up the core dependencies of the application.
/// It uses the `get_it` package to register the dependencies.
/// The `setup` method is called in the `main.dart` file to initialize the dependencies.
sealed class CoreSetup {
  static void setup() {
    /// HTTP CLIENT
    getIt.registerSingleton<HttpClient>(
      HttpClientImplementation(
        Dio(),
      ),
    );
  }
}
