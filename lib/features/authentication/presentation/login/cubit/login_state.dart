import 'package:equatable/equatable.dart';

/// LoginState is the base class for all login states.
/// It extends Equatable to allow for value comparison.
/// It contains a single property, buttonEnabled, which indicates
/// whether the login button should be enabled or not.
class LoginState extends Equatable {
  final bool buttonEnabled;

  /// The constructor for LoginState.
  const LoginState({required this.buttonEnabled});

  @override
  List<Object?> get props => [buttonEnabled];

  LoginState copyWith({
    bool? buttonEnabled,
  }) {
    return LoginState(
      buttonEnabled: buttonEnabled ?? this.buttonEnabled,
    );
  }
}

class LoginInitialState extends LoginState {
  const LoginInitialState() : super(buttonEnabled: false);
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState() : super(buttonEnabled: false);
}

class LoginSuccessState extends LoginState {
  final String token;
  const LoginSuccessState({
    required this.token,
  }) : super(buttonEnabled: true);
  @override
  List<Object?> get props => [token];
}

class LoginFailureState extends LoginState {
  final String errorMessage;

  const LoginFailureState({required this.errorMessage})
      : super(buttonEnabled: false);

  @override
  List<Object?> get props => [errorMessage];
}
