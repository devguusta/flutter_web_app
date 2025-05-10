import 'package:flutter_web_app/core/http/http_client.dart';
import 'package:flutter_web_app/core/http/http_configs.dart';
import 'package:flutter_web_app/features/weather/data/models/weather_status_report_model.dart';
import 'package:flutter_web_app/features/weather/domain/entities/location_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_status_report.dart';
import 'package:flutter_web_app/features/weather/domain/repositories/weather_repository.dart';

/// Implementation of [WeatherRepository] that retrieves data from the OpenWeather API.
///
/// This class handles the communication with the OpenWeather API, converting
/// the API responses into domain entities that can be used by the application.
final class RemoteWeatherRepositoryImpl implements WeatherRepository {
  /// HTTP client used for API requests
  final HttpClient httpClient;

  /// API key for authenticating with the OpenWeather API
  final String apiKey;

  const RemoteWeatherRepositoryImpl({
    required this.httpClient,
    required this.apiKey,
  });

  @override
  Future<WeatherStatusReportEntity> getWeatherByLocation({
    required LocationEntity location,
  }) async {
    final baseUrl = HttpConfigs.weatherUrl;
    final response = await httpClient.get(baseUrl, queryParameters: {
      'lat': location.latitude.toString(),
      'lon': location.longitude.toString(),
      'appid': apiKey,
      'units': 'metric', // Request temperatures in Celsius
    });
    final report =
        WeatherReportModel.fromJson(response as Map<String, dynamic>);
    return report.toEntity();
  }
}
