import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_web_app/core/remote_config/remote_config.dart';
import 'package:flutter_web_app/core/remote_config/remote_config_exception.dart';

class FirebaseRemoteConfigImpl implements RemoteConfig {
  final FirebaseRemoteConfig _remoteConfig;
  FirebaseRemoteConfigImpl({required FirebaseRemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;
  @override
  Future<void> setup() async {
    await _remoteConfig.ensureInitialized();

    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(minutes: 1),
        ),
      );
      await _remoteConfig.fetch();
      await Future.delayed(const Duration(seconds: 1));
      await _remoteConfig.fetchAndActivate();
    } on FirebaseException catch (exception, stackTrace) {
      throw RemoteConfigException(
        error: exception,
        stackTrace: stackTrace,
        message: exception.message ?? 'Error to activate the Remote Config',
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  String getString({required String key}) {
    return _remoteConfig.getString(key);
  }

  @override
  bool getBool({required String key, bool? defaultValue}) {
    return _remoteConfig.getBool(key);
  }

  @override
  int getInt({required String key}) {
    return _remoteConfig.getInt(key);
  }

  @override
  double getDouble({required String key}) {
    return _remoteConfig.getDouble(key);
  }

  @override
  Map<String, dynamic> getJson({required String key}) {
    final result = _remoteConfig.getValue(key);
    if (result is Map<String, dynamic>) {}
    return jsonDecode(result.asString());
  }
}
