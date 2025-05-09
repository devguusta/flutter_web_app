import 'package:flutter_web_app/features/weather/data/models/weather_model.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_daily_data_entity.dart';

final class WeatherDailyDataModel {
  final DateTime date;

  final double minimumTemperature;

  final double maximumTemperature;

  final WeatherModel weather;
  const WeatherDailyDataModel({
    required this.date,
    required this.minimumTemperature,
    required this.maximumTemperature,
    required this.weather,
  });

  factory WeatherDailyDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDailyDataModel(
      date: DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000),
      minimumTemperature: (json['temp']['min'] as num).toDouble(),
      maximumTemperature: (json['temp']['max'] as num).toDouble(),
      weather: WeatherModel.fromJson(
        (json['weather'] as List).cast<Map<String, dynamic>>().first,
      ),
    );
  }

  WeatherDailyDataEntity toEntity() {
    return WeatherDailyDataEntity(
      date: date,
      minimumTemperature: minimumTemperature,
      maximumTemperature: maximumTemperature,
      weather: weather.toEntity(),
    );
  }
}
