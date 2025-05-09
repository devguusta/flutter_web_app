import 'package:equatable/equatable.dart';

import 'weather.dart';

/// This class represents the weather data entity, which contains the current weather data.
/// It includes temperature, pressure, humidity, wind speed, wind direction, and weather condition.
class WeatherDataEntity extends Equatable {
  const WeatherDataEntity({
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDegrees,
    required this.weather,
  });

  final double temperature;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final double windDegrees;
  final Weather weather;

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
