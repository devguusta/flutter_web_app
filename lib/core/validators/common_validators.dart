sealed class CommonValidators {
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  // Password must be at least 8 characters long, contain at least one uppercase letter,
  // one lowercase letter, one number, and one special character
  // and no whitespace.
  // THis function should be used only in registration form.
  // The regex pattern is explained as follows:
  // ^ - start of the string
  // (?=.*[a-z]) - at least one lowercase letter
  // (?=.*[A-Z]) - at least one uppercase letter
  // (?=.*\d) - at least one digit
  // (?=.*[@$!%*?&]) - at least one special character
  // [A-Za-z\d@$!%*?&] - allowed characters
  // {8,} - at least 8 characters
  // $ - end of the string
  static bool isValidPassword(String password) {
    final regex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }
}
