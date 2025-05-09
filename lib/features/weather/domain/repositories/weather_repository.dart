import 'package:flutter_web_app/features/weather/domain/entities/location_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_status_report.dart';

abstract interface class WeatherRepository {
  Future<WeatherStatusReportEntity> getWeatherByLocation({
    required LocationEntity location,
  });
}
