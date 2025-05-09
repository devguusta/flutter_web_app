import 'package:equatable/equatable.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_daily_data_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_data_entity.dart';

/// This class represents the weather report entity, which contains the current weather, hourly forecast, and daily forecast.
class WeatherStatusReportEntity extends Equatable {
  const WeatherStatusReportEntity({
    required this.current,
    required this.hourly,
    required this.daily,
  });

  final WeatherDataEntity current;
  final List<WeatherDataEntity> hourly;
  final List<WeatherDailyDataEntity> daily;

  @override
  List<Object?> get props => [
        current,
        hourly,
        daily,
      ];
}
