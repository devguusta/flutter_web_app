import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_app/core/validators/common_validators.dart';
import 'package:flutter_web_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:flutter_web_app/features/authentication/presentation/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;
  LoginCubit(this._authenticationRepository) : super(const LoginInitialState());

  /// This method is responsible for handling the login process.
  /// It takes an email and password as parameters.
  void login({required String email, required String password}) async {
    emit(const LoginLoadingState());
    try {
      final token = await _authenticationRepository.authenticate(
        email: email,
        password: password,
      );
      emit(LoginSuccessState(token: token));
    } catch (_) {
      emit(LoginFailureState(errorMessage: 'Login failed'));
    }
  }

  /// This method is responsible for enabling or disabling the login button.
  /// It takes an email and password as parameters.
  /// It checks if the email and password are valid.
  /// If they are valid, it enables the button.
  void enableButton({required String email, required String password}) {
    final bool buttonEnabled =
        CommonValidators.isValidEmail(email) && password.isNotEmpty;
    emit(state.copyWith(buttonEnabled: buttonEnabled));
  }
}
