import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/core/http/http_configs.dart';
import 'package:flutter_web_app/features/weather/data/repositories/remote/remote_weather_repository_impl.dart';
import 'package:flutter_web_app/features/weather/domain/entities/location_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_daily_data_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_data_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_status_report.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mock_class.dart';
import '../../fixtures/weather_status_report_mock.dart';

void main() {
  const String apiKey = 'test_api_key';
  final client = HttpClientMock();
  final repository = RemoteWeatherRepositoryImpl(
    httpClient: client,
    apiKey: apiKey,
  );
  const location = LocationEntity(latitude: 30, longitude: 30);
  final queryParameters = {
    'lat': location.latitude.toString(),
    'lon': location.longitude.toString(),
    'appid': apiKey,
    'units': 'metric'
  };

  final current = WeatherDataEntity(
    temperature: 292.55,
    pressure: 1014,
    humidity: 89,
    windSpeed: 3.13,
    windDegrees: 93,
    weather: const Weather(
      title: 'Clouds',
      icon: "04d",
    ),
  );

  final hourly = [
    WeatherDataEntity(
      temperature: 292.01,
      pressure: 1014,
      humidity: 91,
      windSpeed: 2.58,
      windDegrees: 86,
      weather: const Weather(
        title: "Clouds",
        icon: "04n",
      ),
    ),
  ];

  final daily = [
    WeatherDailyDataEntity(
      date: DateTime.fromMillisecondsSinceEpoch(1684951200 * 1000),
      minimumTemperature: 290.69,
      maximumTemperature: 300.35,
      weather: const Weather(
        title: "Rain",
        icon: "10d",
      ),
    ),
  ];

  tearDown(() {
    reset(client);
  });

  group('Remote weather repository IMPL', () {
    test(
        'Should return [WeatherStatusReportEntity] when api call return successful',
        () async {
      when(
        () => client.get(
          HttpConfigs.weatherUrl,
          queryParameters: queryParameters,
        ),
      ).thenAnswer(
        (_) async => Future.value(jsonMock),
      );

      final result = await repository.getWeatherByLocation(
        location: location,
      );

      expect(result, isA<WeatherStatusReportEntity>());

      expect(
          result,
          WeatherStatusReportEntity(
              current: current, hourly: hourly, daily: daily));
    });

    test('Should throw when api call return error', () async {
      when(
        () => client.get(
          HttpConfigs.weatherUrl,
          queryParameters: queryParameters,
        ),
      ).thenThrow(Exception('Error'));

      expect(
        () => repository.getWeatherByLocation(location: location),
        throwsA(isA<Exception>()),
      );
    });
  });
}
