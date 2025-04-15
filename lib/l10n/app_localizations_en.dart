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
}
