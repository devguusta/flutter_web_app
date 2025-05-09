class HttpConfigs {
  static String weatherUrl = const String.fromEnvironment(
    'WEATHER_BASE_URL',
    defaultValue: '',
  );

  static String weatherApiKey = const String.fromEnvironment(
    'WEATHER_API_KEY',
    defaultValue: '',
  );

  static String reverseAddressUrl = const String.fromEnvironment(
    'REVERSE_BASE_URL',
    defaultValue: '',
  );
}
