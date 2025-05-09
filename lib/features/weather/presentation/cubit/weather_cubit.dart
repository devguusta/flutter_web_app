import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_app/features/weather/domain/entities/address_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/location_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_status_report.dart';
import 'package:flutter_web_app/features/weather/domain/exceptions/location_exceptions.dart';
import 'package:flutter_web_app/features/weather/domain/repositories/address_repository.dart';
import 'package:flutter_web_app/features/weather/domain/repositories/location_repository.dart';
import 'package:flutter_web_app/features/weather/domain/repositories/weather_repository.dart';

import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({
    required this.weatherRepository,
    required this.locationRepository,
    required this.addressRepository,
  }) : super(const WeatherInitialState());

  final WeatherRepository weatherRepository;
  final LocationRepository locationRepository;
  final AddressRepository addressRepository;

  Future<void> getWeather() async {
    emit(const WeatherLoadingState());
    final location = await _getLocation();
    try {
      if (location == null) return;
      final address = await _getAddress(location: location);
      final weather = await _getWeatherStatusReport(location: location);
      emit(WeatherLoadedState(weatherReport: weather, address: address));
    } on LocationException {
      return;
    } catch (_) {
      emit(WeatherFailureState());
    }
  }

  Future<LocationEntity?> _getLocation() async {
    try {
      final result = await locationRepository.getCurrentLocation();
      return result;
    } on LocationException catch (e) {
      if (e is GpsDisabledException) {
        emit(WeatherLocationFailureState(error: e));
      } else if (e is LocationPermissionDeniedException) {
        emit(WeatherLocationFailureState(error: e));
      } else if (e is LocationPermitionDenieForeverException) {
        emit(WeatherLocationFailureState(error: e));
      } else {
        emit(WeatherLocationFailureState(error: e));
      }
    }
    return null;
  }

  Future<AddressEntity> _getAddress({required LocationEntity location}) =>
      addressRepository.getAddressFromLocation(location: location);

  Future<WeatherStatusReportEntity> _getWeatherStatusReport(
          {required LocationEntity location}) =>
      weatherRepository.getWeatherByLocation(location: location);
}
