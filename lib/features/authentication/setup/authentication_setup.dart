import 'package:flutter_web_app/core/getit/getit_instance.dart';
import 'package:flutter_web_app/features/authentication/data/repository/local_authentication_repository_impl.dart';
import 'package:flutter_web_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:flutter_web_app/features/authentication/presentation/login/cubit/login_cubit.dart';

sealed class AuthenticationSetup {
  /// This method sets up the authentication dependencies.
  static void setup() {
    // Register the authentication repository
    getIt.registerFactory<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(),
    );

    // cubit
    getIt.registerFactory<LoginCubit>(
      () => LoginCubit(getIt<AuthenticationRepository>()),
    );
  }
}
