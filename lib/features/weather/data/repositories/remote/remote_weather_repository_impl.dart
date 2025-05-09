import 'package:flutter_web_app/core/http/http_client.dart';
import 'package:flutter_web_app/core/http/http_configs.dart';
import 'package:flutter_web_app/features/weather/data/models/weather_status_report_model.dart';
import 'package:flutter_web_app/features/weather/domain/entities/location_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_status_report.dart';
import 'package:flutter_web_app/features/weather/domain/repositories/weather_repository.dart';

final class RemoteWeatherRepositoryImpl implements WeatherRepository {
  const RemoteWeatherRepositoryImpl({
    required this.httpClient,
    required this.apiKey,
  });

  final HttpClient httpClient;
  final String apiKey;

  @override
  Future<WeatherStatusReportEntity> getWeatherByLocation({
    required LocationEntity location,
  }) async {
    final baseUrl = HttpConfigs.weatherUrl;
    final response = await httpClient.get(baseUrl, queryParameters: {
      'lat': location.latitude.toString(),
      'lon': location.longitude.toString(),
      'appid': apiKey,
      'units': 'metric',
    });
    final report =
        WeatherReportModel.fromJson(response as Map<String, dynamic>);
    return report.toEntity();
  }
}
