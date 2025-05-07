import 'package:flutter_web_app/features/authentication/domain/repository/authentication_repository.dart';

/// This class is responsible for implementing the authentication repository.
/// It's a mock implementation of the [AuthenticationRepository] interface.
/// It implements the [AuthenticationRepository] interface.
/// It uses the [Future] class to simulate
/// an asynchronous operation.
/// It returns a [String] representing the authentication token.

final class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<String> authenticate(
      {required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value('token');
  }
}
