class RemoteConfigException implements Exception {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;

  RemoteConfigException({
    required this.message,
    this.error,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'RemoteConfigException: $message';
  }
}
