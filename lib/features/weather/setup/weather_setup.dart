import 'package:flutter_web_app/core/getit/getit_instance.dart';
import 'package:flutter_web_app/core/http/http_client.dart';
import 'package:flutter_web_app/core/http/http_configs.dart';
import 'package:flutter_web_app/features/weather/data/repositories/remote/remote_address_repository_impl.dart';
import 'package:flutter_web_app/features/weather/data/repositories/remote/remote_weather_repository_impl.dart';
import 'package:flutter_web_app/features/weather/data/repositories/system/system_location_repository_impl.dart';
import 'package:flutter_web_app/features/weather/domain/repositories/address_repository.dart';
import 'package:flutter_web_app/features/weather/domain/repositories/location_repository.dart';
import 'package:flutter_web_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:flutter_web_app/features/weather/presentation/cubit/weather_cubit.dart';

sealed class WeatherSetup {
  /// This method sets up the weather dependencies.
  static void setup() {
    // Repositories
    getIt.registerFactory<WeatherRepository>(
      () => RemoteWeatherRepositoryImpl(
        httpClient: getIt.get<HttpClient>(),
        apiKey: HttpConfigs.weatherApiKey,
      ),
    );

    getIt.registerFactory<LocationRepository>(
      () => SystemLocationRepository(),
    );

    getIt.registerFactory<AddressRepository>(
      () => RemoteAddressRepositoryImpl(
        httpClient: getIt.get<HttpClient>(),
      ),
    );

    // Register the weather cubit
    getIt.registerFactory<WeatherCubit>(
      () => WeatherCubit(
        weatherRepository: getIt.get<WeatherRepository>(),
        locationRepository: getIt.get<LocationRepository>(),
        addressRepository: getIt.get<AddressRepository>(),
      ),
    );
  }
}
