import 'package:equatable/equatable.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather.dart';

/// Represents weather data for a specific day in the forecast.
///
/// This entity contains daily weather information including date, temperature range
/// (minimum and maximum values), and general weather conditions.
class WeatherDailyDataEntity extends Equatable {
  /// The date for this forecast
  final DateTime date;

  /// Minimum temperature forecasted for the day in Celsius
  final double minimumTemperature;

  /// Maximum temperature forecasted for the day in Celsius
  final double maximumTemperature;

  /// Weather conditions for the day (e.g., clouds, rain, clear)
  final Weather weather;

  const WeatherDailyDataEntity({
    required this.date,
    required this.minimumTemperature,
    required this.maximumTemperature,
    required this.weather,
  });

  @override
  List<Object?> get props => [
        date,
        minimumTemperature,
        maximumTemperature,
        weather,
      ];
}
