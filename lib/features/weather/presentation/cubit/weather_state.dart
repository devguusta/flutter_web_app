import 'package:equatable/equatable.dart';
import 'package:flutter_web_app/features/weather/domain/entities/address_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_status_report.dart';
import 'package:flutter_web_app/features/weather/domain/exceptions/location_exceptions.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

final class WeatherInitialState extends WeatherState {
  const WeatherInitialState();
}

final class WeatherLocationFailureState extends WeatherState {
  const WeatherLocationFailureState({
    required this.error,
  });

  final LocationException error;

  @override
  List<Object?> get props => [
        super.props,
        error,
      ];
}

final class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();
}

final class WeatherFailureState extends WeatherState {
  const WeatherFailureState();
}

final class WeatherLoadedState extends WeatherState {
  const WeatherLoadedState({
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
