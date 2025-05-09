import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/features/weather/domain/entities/entities.dart';
import 'package:flutter_web_app/features/weather/domain/exceptions/location_exceptions.dart';
import 'package:flutter_web_app/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:flutter_web_app/features/weather/presentation/cubit/weather_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mock_class.dart';

void main() {
  final weatherRepository = WeatherRepositoryMock();
  final addressRepository = AddressRepositoryMock();
  final locationRepository = LocationRepositoryMock();
  final location = LocationEntity(latitude: 30, longitude: 30);
  final current = WeatherDataEntity(
    temperature: 292.55,
    pressure: 1014,
    humidity: 89,
    windSpeed: 3.13,
    windDegrees: 93,
    weather: const Weather(
      title: 'Clouds',
      icon: "04d",
    ),
  );

  final hourly = [
    WeatherDataEntity(
      temperature: 292.01,
      pressure: 1014,
      humidity: 91,
      windSpeed: 2.58,
      windDegrees: 86,
      weather: const Weather(
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
      weather: const Weather(
        title: "Rain",
        icon: "10d",
      ),
    ),
  ];
  final address = AddressEntity(city: 'NOVA IGUACU', state: 'RJ');
  final weatherStatusReport =
      WeatherStatusReportEntity(current: current, hourly: hourly, daily: daily);

  final gpsDisabledException = GpsDisabledException();

  final LocationPermissionDeniedException locationPermissionDeniedException =
      LocationPermissionDeniedException();

  final LocationPermitionDenieForeverException
      locationPermitionDenieForeverException =
      LocationPermitionDenieForeverException();

  final unknowException = LocationUnknownException();
  tearDown(() {
    reset(weatherRepository);
    reset(addressRepository);
    reset(locationRepository);
  });

  group('Weather cubit -  success', () {
    void successMock() {
      when(() => locationRepository.getCurrentLocation()).thenAnswer(
        (_) async => location,
      );
      when(
        () => addressRepository.getAddressFromLocation(location: location),
      ).thenAnswer((_) async => address);
      when(() => weatherRepository.getWeatherByLocation(location: location))
          .thenAnswer((_) async => WeatherStatusReportEntity(
              current: current, hourly: hourly, daily: daily));
    }

    blocTest<WeatherCubit, WeatherState>(
      'Should emit success state when wall repositories return success ',
      build: () => WeatherCubit(
        weatherRepository: weatherRepository,
        locationRepository: locationRepository,
        addressRepository: addressRepository,
      ),
      setUp: successMock,
      act: (cubit) => cubit.getWeather(),
      expect: () => [
        WeatherLoading(),
        WeatherLoaded(weatherReport: weatherStatusReport, address: address)
      ],
    );
  });
  group('Weather cubit -  generic errors', () {
    blocTest<WeatherCubit, WeatherState>(
      'Should emit WeatherFailure when failure to get address ',
      build: () => WeatherCubit(
        weatherRepository: weatherRepository,
        locationRepository: locationRepository,
        addressRepository: addressRepository,
      ),
      setUp: () {
        when(() => locationRepository.getCurrentLocation()).thenAnswer(
          (_) async => location,
        );
        when(() => addressRepository.getAddressFromLocation(location: location))
            .thenThrow(Exception());
      },
      act: (cubit) => cubit.getWeather(),
      expect: () => [WeatherLoading(), WeatherFailure()],
    );
    blocTest<WeatherCubit, WeatherState>(
      'Should emit WeatherFailure when failure to get weather status report ',
      build: () => WeatherCubit(
        weatherRepository: weatherRepository,
        locationRepository: locationRepository,
        addressRepository: addressRepository,
      ),
      setUp: () {
        when(() => locationRepository.getCurrentLocation()).thenAnswer(
          (_) async => location,
        );
        when(() => weatherRepository.getWeatherByLocation(location: location))
            .thenThrow(Exception());
      },
      act: (cubit) => cubit.getWeather(),
      expect: () => [WeatherLoading(), WeatherFailure()],
    );
  });

  group('Weather cubit - location errors', () {
    void errorLocationMock(LocationException exception) {
      when(() => locationRepository.getCurrentLocation()).thenThrow(exception);
    }

    blocTest<WeatherCubit, WeatherState>(
      'Should emit failure state with [GpsDisabledException] exception when gpsIsDisabled',
      build: () => WeatherCubit(
        weatherRepository: weatherRepository,
        locationRepository: locationRepository,
        addressRepository: addressRepository,
      ),
      setUp: () {
        errorLocationMock(gpsDisabledException);
      },
      act: (cubit) => cubit.getWeather(),
      expect: () => [
        WeatherLoading(),
        WeatherLocationFailure(error: gpsDisabledException)
      ],
    );
    blocTest<WeatherCubit, WeatherState>(
      'Should emit failure state with [LocationPermissionDeniedException] exception when permission is denied',
      build: () => WeatherCubit(
        weatherRepository: weatherRepository,
        locationRepository: locationRepository,
        addressRepository: addressRepository,
      ),
      setUp: () {
        errorLocationMock(locationPermissionDeniedException);
      },
      act: (cubit) => cubit.getWeather(),
      expect: () => [
        WeatherLoading(),
        WeatherLocationFailure(error: locationPermissionDeniedException)
      ],
    );
    blocTest<WeatherCubit, WeatherState>(
      'Should emit failure state with [LocationPermitionDenieForeverException] exception when permission is permanent denied',
      build: () => WeatherCubit(
        weatherRepository: weatherRepository,
        locationRepository: locationRepository,
        addressRepository: addressRepository,
      ),
      setUp: () {
        errorLocationMock(locationPermitionDenieForeverException);
      },
      act: (cubit) => cubit.getWeather(),
      expect: () => [
        WeatherLoading(),
        WeatherLocationFailure(error: locationPermitionDenieForeverException)
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'Should emit failure state with [LocationUnknownException] exception when throw generic location error',
      build: () => WeatherCubit(
        weatherRepository: weatherRepository,
        locationRepository: locationRepository,
        addressRepository: addressRepository,
      ),
      setUp: () {
        errorLocationMock(unknowException);
      },
      act: (cubit) => cubit.getWeather(),
      expect: () =>
          [WeatherLoading(), WeatherLocationFailure(error: unknowException)],
    );
  });
}
