import 'package:equatable/equatable.dart';
import 'package:flutter_web_app/features/weather/domain/entities/address_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_status_report.dart';
import 'package:flutter_web_app/features/weather/domain/exceptions/location_exceptions.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

final class WeatherLocationFailure extends WeatherState {
  const WeatherLocationFailure({
    required this.error,
  });

  final LocationException error;

  @override
  List<Object?> get props => [
        super.props,
        error,
      ];
}

final class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

final class WeatherFailure extends WeatherState {
  const WeatherFailure();
}

final class WeatherLoaded extends WeatherState {
  const WeatherLoaded({
    required this.weatherReport,
    this.address,
  });

  final WeatherStatusReportEntity weatherReport;
  final AddressEntity? address;

  @override
  List<Object?> get props => [
        super.props,
        weatherReport,
        address,
      ];
}
