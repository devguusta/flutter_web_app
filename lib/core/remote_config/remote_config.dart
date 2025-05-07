/// This file defines an abstract interface for a remote configuration service.
abstract interface class RemoteConfig {
  /// Initializes the remote config.
  /// This method should be called before using any other methods in this class.
  Future<void> setup();

  /// Returns a boolean value for the specified key.
  bool getBool({required String key});

  /// Returns an integer value for the specified key.
  int getInt({required String key});

  /// Returns a double value for the specified key.
  double getDouble({required String key});

  /// Returns a string value for the specified key.
  String getString({required String key});

  /// Returns a JSON object for the specified key.
  Map<String, dynamic> getJson({required String key});
}
