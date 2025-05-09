class HttpConfigs {
  //static final _appConfig = getIt.get<RemoteConfig>().getJson(key: 'appConfig');
  static final _appConfig = {
    "REVERSE_BASE_URL": "https://nominatim.openstreetmap.org/reverse",
    "BASE_URL": "https://api.openweathermap.org/data/3.0/onecall",
    "API_KEY": "e85d2497d9091887263486bc587aee9a"
  };
  static String weatherUrl = _appConfig['BASE_URL']!;
  static String weatherApiKey = _appConfig['API_KEY']!;
  static String reverseAddressUrl = _appConfig['REVERSE_BASE_URL']!;
}
