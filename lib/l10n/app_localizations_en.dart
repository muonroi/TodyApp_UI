// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get username => 'Username';

  @override
  String get enterUsernameHint => 'Enter your username';

  @override
  String get password => 'Password';

  @override
  String get enterPasswordHint => 'Enter your password';

  @override
  String get loginButton => 'LOGIN';

  @override
  String get orDivider => 'Or';

  @override
  String get googleLogin => 'Google';

  @override
  String get appleLogin => 'Apple';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get register => 'Register';

  @override
  String get usernameValidationError => 'Please enter your username';

  @override
  String get passwordValidationError => 'Please enter your password';

  @override
  String get tudyAppTitle => 'Tudy App';

  @override
  String get errorDialogTitle => 'Error List';

  @override
  String get errorCodeHeader => 'Error Code';

  @override
  String get errorMessageHeader => 'Error Message';

  @override
  String get closeButton => 'Close';

  @override
  String get notAvailable => 'N/A';

  @override
  String get generalErrorOccurred => 'An error occurred';

  @override
  String get loginSuccessMessage => 'Login successful! Welcome back!';

  @override
  String get registrationSuccessMessage => 'Registration successful! Welcome aboard!';

  @override
  String get registrationFailedMessage => 'Registration failed! Please try again.';

  @override
  String get emailValidationErrorEmpty => 'Please enter your email';

  @override
  String get emailValidationErrorInvalid => 'Please enter a valid email';

  @override
  String get phoneValidationErrorEmpty => 'Please enter your phone number';

  @override
  String get phoneValidationErrorInvalid => 'Please enter a valid phone number';

  @override
  String get fullNameValidationErrorEmpty => 'Please enter your full name';

  @override
  String get email => 'Email';

  @override
  String get phone => 'Phone Number';

  @override
  String get fullName => 'Full Name';

  @override
  String get enterEmailHint => 'Enter your email';

  @override
  String get enterPhoneNumberHint => 'Enter your phone number';

  @override
  String get enterFullNameHint => 'Enter your full name';

  @override
  String get passwordValidationErrorLength => 'Password must be at least 8 characters long';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get enterConfirmPasswordHint => 'Enter your confirm password';

  @override
  String get confirmPasswordValidationErrorEmpty => 'Please enter your confirm password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get registerButton => 'REGISTER';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get usernameValidationErrorLength => 'Username has invalid length (maximum 50)';

  @override
  String get usernameValidationErrorChars => 'Username contains invalid characters (a-z, A-Z) and numbers (0-9) and _';

  @override
  String get fullNameValidationErrorMinWords => 'Full name must contain at least 2 words';

  @override
  String get passwordValidationErrorComplexity => 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
}
