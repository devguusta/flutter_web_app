import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/core/http/http_configs.dart';
import 'package:flutter_web_app/features/weather/data/repositories/remote/remote_weather_repository_impl.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_status_report.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mock_class.dart';
import '../../../../../mocks/weather_mock.dart';
import '../../fixtures/weather_status_report_mock.dart';

void main() {
  const String apiKey = 'test_api_key';
  final client = HttpClientMock();
  final repository = RemoteWeatherRepositoryImpl(
    httpClient: client,
    apiKey: apiKey,
  );

  final queryParameters = {
    'lat': location.latitude.toString(),
    'lon': location.longitude.toString(),
    'appid': apiKey,
    'units': 'metric'
  };

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
