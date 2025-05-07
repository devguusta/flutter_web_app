import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:flutter_web_app/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:flutter_web_app/features/authentication/presentation/login/cubit/login_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mock_class.dart';

void main() {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepositoryMock();

  final email = 'test@gmail.com';
  final password = 'password';
  final String fakeToken = 'fakeToken';

  tearDown(() {
    reset(authenticationRepository);
  });
  group('Login Cubit tests', () {
    blocTest<LoginCubit, LoginState>(
      'Should emit success state when login is successful',
      build: () => LoginCubit(authenticationRepository),
      setUp: () {
        when(() => authenticationRepository.authenticate(
              email: email,
              password: password,
            )).thenAnswer((_) async => fakeToken);
      },
      act: (cubit) => cubit.login(email: email, password: password),
      expect: () => [
        LoginLoadingState(),
        LoginSuccessState(
          token: fakeToken,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'Should emit error state when login fails',
      build: () => LoginCubit(authenticationRepository),
      setUp: () {
        when(() => authenticationRepository.authenticate(
              email: email,
              password: password,
            )).thenThrow(Exception('Login failed'));
      },
      act: (cubit) => cubit.login(email: email, password: password),
      expect: () => [
        LoginLoadingState(),
        LoginFailureState(errorMessage: 'Login failed'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'Should emit button enabled state when email and password are valid',
      build: () => LoginCubit(authenticationRepository),
      act: (cubit) => cubit.enableButton(email: email, password: password),
      expect: () => [
        LoginInitialState().copyWith(buttonEnabled: true),
      ],
    );
    blocTest<LoginCubit, LoginState>(
      'Should emit button disabled state when email is invalid',
      build: () => LoginCubit(authenticationRepository),
      seed: () => LoginInitialState().copyWith(buttonEnabled: true),
      act: (cubit) =>
          cubit.enableButton(email: 'invalidEmail', password: password),
      expect: () => [
        LoginInitialState().copyWith(buttonEnabled: false),
      ],
    );
  });
}
