import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_web_app/core/http/http_client.dart';
import 'package:flutter_web_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:flutter_web_app/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:flutter_web_app/features/authentication/presentation/login/cubit/login_state.dart';
import 'package:flutter_web_app/features/weather/domain/repositories/address_repository.dart';
import 'package:flutter_web_app/features/weather/domain/repositories/location_repository.dart';
import 'package:flutter_web_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:flutter_web_app/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:flutter_web_app/features/weather/presentation/cubit/weather_state.dart';
import 'package:mocktail/mocktail.dart';

/// CLIENTS
class HttpClientMock extends Mock implements HttpClient {}

/// REPOSITORIES MOCKS
class AuthenticationRepositoryMock extends Mock
    implements AuthenticationRepository {}

class WeatherRepositoryMock extends Mock implements WeatherRepository {}

class AddressRepositoryMock extends Mock implements AddressRepository {}

class LocationRepositoryMock extends Mock implements LocationRepository {}

/// CUBITS
///
class LoginCubitMock extends MockCubit<LoginState> implements LoginCubit {}

class WeatherCubitMock extends MockCubit<WeatherState>
    implements WeatherCubit {}
