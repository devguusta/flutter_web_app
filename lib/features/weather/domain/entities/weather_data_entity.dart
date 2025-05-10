import 'package:equatable/equatable.dart';

import 'weather.dart';

/// Represents weather data for a specific point in time.
///
/// This entity contains comprehensive weather information for either
/// the current conditions or a specific hour in the hourly forecast.
class WeatherDataEntity extends Equatable {
  /// Temperature in Celsius
  final double temperature;

  /// Atmospheric pressure in hPa (hectopascal)
  final int pressure;

  /// Relative humidity percentage (0-100)
  final int humidity;

  /// Wind speed in meters per second
  final double windSpeed;

  /// Wind direction in degrees (meteorological)
  /// 0° indicates wind from north, 90° from east, etc.
  final double windDegrees;

  /// General weather condition
  final Weather weather;

  const WeatherDataEntity({
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDegrees,
    required this.weather,
  });

  @override
  List<Object?> get props => [
        temperature,
        pressure,
        humidity,
        windSpeed,
        windDegrees,
        weather,
      ];
}
