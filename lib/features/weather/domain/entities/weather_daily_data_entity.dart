import 'package:equatable/equatable.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather.dart';

/// This class represents the daily weather data entity, which contains the date, minimum and maximum temperatures, and weather conditions.
/// It is used to represent the daily weather forecast.
class WeatherDailyDataEntity extends Equatable {
  const WeatherDailyDataEntity({
    required this.date,
    required this.minimumTemperature,
    required this.maximumTemperature,
    required this.weather,
  });

  final DateTime date;
  final double minimumTemperature;
  final double maximumTemperature;
  final Weather weather;

  @override
  List<Object?> get props => [
        date,
        minimumTemperature,
        maximumTemperature,
        weather,
      ];
}
