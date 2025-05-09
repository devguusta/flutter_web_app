import 'package:flutter_web_app/features/weather/domain/entities/weather.dart';

final class WeatherModel {
  final String title;
  final String icon;
  const WeatherModel({required this.title, required this.icon});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      title: json['main'],
      icon: json['icon'],
    );
  }

  Weather toEntity() {
    return Weather(
      title: title,
      icon: icon,
    );
  }
}
