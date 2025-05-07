abstract interface class AuthenticationRepository {
  /// Authenticates a user with the given [email] and [password].
  ///
  /// Returns a [Future] that resolves to a [String] representing the authentication token.
  Future<String> authenticate(
      {required String email, required String password});
}
