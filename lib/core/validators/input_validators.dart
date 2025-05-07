import 'package:flutter_web_app/core/validators/common_validators.dart';

/// This class contains a collection of input validators that can be used to validate user input in forms.
sealed class InputValidators {
  /// A function that validate email input.
  /// It checks if the email is empty or if it is not a valid email format.
  /// If the email is empty or not valid, it returns an error message.
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Please enter your email';
    } else if (!CommonValidators.isValidEmail(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// A function that validate password input.
  /// It checks if the password is empty or if it is less than 6 characters.
  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Please enter your password';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}
