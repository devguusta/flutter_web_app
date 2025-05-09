import 'package:flutter_web_app/features/weather/data/models/weather_daily_data_model.dart';
import 'package:flutter_web_app/features/weather/data/models/weather_data_model.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_status_report.dart';

final class WeatherReportModel {
  final WeatherDataModel current;
  final List<WeatherDataModel> hourly;
  final List<WeatherDailyDataModel> daily;
  const WeatherReportModel({
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory WeatherReportModel.fromJson(Map<String, dynamic> json) {
    return WeatherReportModel(
      current: WeatherDataModel.fromJson(json['current']),
      hourly: (json['hourly'] as List)
          .cast<Map<String, dynamic>>()
          .map(WeatherDataModel.fromJson)
          .toList(),
      daily: (json['daily'] as List)
          .cast<Map<String, dynamic>>()
          .map(WeatherDailyDataModel.fromJson)
          .toList(),
    );
  }

  WeatherStatusReportEntity toEntity() {
    return WeatherStatusReportEntity(
      current: current.toEntity(),
      hourly: hourly.map((e) => e.toEntity()).toList(),
      daily: daily.map((e) => e.toEntity()).toList(),
    );
  }
}
