import 'package:flutter_web_app/core/getit/getit_instance.dart';
import 'package:flutter_web_app/core/remote_config/remote_config.dart';

class HttpConfigs {
  static final _appConfig =
      getIt.get<RemoteConfig>().getJson(key: 'app_config');
  static String weatherUrl = _appConfig['BASE_URL'];
  static String weatherApiKey = _appConfig['API_KEY'];
  static String reverseAddressUrl = _appConfig['REVERSE_BASE_URL'];
}
