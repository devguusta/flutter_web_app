import 'package:equatable/equatable.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_daily_data_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_data_entity.dart';

/// This class represents the weather report entity, which contains the current weather, hourly forecast, and daily forecast.
/// Represents a weather status report containing current, hourly, and daily weather data.
///
/// This entity serves as the core domain model for weather information displayed
/// in the application. It encapsulates all weather-related data including current
/// conditions, hourly forecasts, and daily forecasts.
///
/// Related classes:
/// - [WeatherDataEntity]: Represents current or hourly weather data
/// - [WeatherDailyDataEntity]: Represents daily weather forecast data
class WeatherStatusReportEntity extends Equatable {
  /// Current weather conditions
  final WeatherDataEntity current;

  /// Weather forecast for the next 24 hours
  /// Each item represents weather data for a specific hour
  final List<WeatherDataEntity> hourly;

  /// Daily weather forecast for the next several days
  /// Each item represents weather data for a specific day
  final List<WeatherDailyDataEntity> daily;

  const WeatherStatusReportEntity({
    required this.current,
    required this.hourly,
    required this.daily,
  });

  @override
  List<Object?> get props => [
        current,
        hourly,
        daily,
      ];
}

