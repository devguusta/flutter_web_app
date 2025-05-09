import 'package:flutter_web_app/features/weather/domain/entities/address_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/location_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_daily_data_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_data_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_status_report.dart';
import 'package:flutter_web_app/features/weather/domain/exceptions/location_exceptions.dart';

const location = LocationEntity(latitude: 30, longitude: 30);
const current = WeatherDataEntity(
  temperature: 292.55,
  pressure: 1014,
  humidity: 89,
  windSpeed: 3.13,
  windDegrees: 93,
  weather: Weather(
    title: 'Clouds',
    icon: "04d",
  ),
);

const hourly = [
  WeatherDataEntity(
    temperature: 292.01,
    pressure: 1014,
    humidity: 91,
    windSpeed: 2.58,
    windDegrees: 86,
    weather: Weather(
      title: "Clouds",
      icon: "04n",
    ),
  ),
];

final daily = [
  WeatherDailyDataEntity(
    date: DateTime.fromMillisecondsSinceEpoch(1684951200 * 1000),
    minimumTemperature: 290.69,
    maximumTemperature: 300.35,
    weather: Weather(
      title: "Rain",
      icon: "10d",
    ),
  ),
];
const address = AddressEntity(city: 'NOVA IGUACU', state: 'RJ');
final weatherStatusReport =
    WeatherStatusReportEntity(current: current, hourly: hourly, daily: daily);

const gpsDisabledException = GpsDisabledException();

const LocationPermissionDeniedException locationPermissionDeniedException =
    LocationPermissionDeniedException();

const LocationPermitionDenieForeverException
    locationPermitionDenieForeverException =
    LocationPermitionDenieForeverException();

const unknowException = LocationUnknownException();
