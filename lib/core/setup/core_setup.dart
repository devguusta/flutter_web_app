import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_web_app/core/getit/getit_instance.dart';
import 'package:flutter_web_app/core/http/http_client.dart';
import 'package:flutter_web_app/core/http/http_client_implementation.dart';
import 'package:flutter_web_app/core/remote_config/firebase_remote_config_impl.dart';
import 'package:flutter_web_app/core/remote_config/remote_config.dart';

/// This class is responsible for setting up the core dependencies of the application.
/// It uses the `get_it` package to register the dependencies.
/// The `setup` method is called in the `main.dart` file to initialize the dependencies.
sealed class CoreSetup {
  static void setup() {
    /// remote config

    getIt.registerSingleton<RemoteConfig>(
      FirebaseRemoteConfigImpl(
        remoteConfig: FirebaseRemoteConfig.instance,
      ),
    );

    /// HTTP CLIENT
    getIt.registerSingleton<HttpClient>(
      HttpClientImplementation(),
    );
  }
}
