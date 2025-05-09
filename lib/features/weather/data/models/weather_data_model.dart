import 'package:flutter_web_app/features/weather/data/models/weather_model.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_data_entity.dart';

final class WeatherDataModel {
  final double temperature;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final double windDegrees;
  final WeatherModel weather;
  const WeatherDataModel({
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDegrees,
    required this.weather,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      temperature: (json['temp'] as num).toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      windSpeed: (json['wind_speed'] as num).toDouble(),
      windDegrees: (json['wind_deg'] as num).toDouble(),
      weather: WeatherModel.fromJson(
        (json['weather'] as List).cast<Map<String, dynamic>>().first,
      ),
    );
  }

  WeatherDataEntity toEntity() {
    return WeatherDataEntity(
      temperature: temperature,
      pressure: pressure,
      humidity: humidity,
      windSpeed: windSpeed,
      windDegrees: windDegrees,
      weather: weather.toEntity(),
    );
  }
}
