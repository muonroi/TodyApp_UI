// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Enter your username`
  String get enterUsernameHint {
    return Intl.message(
      'Enter your username',
      name: 'enterUsernameHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter your password`
  String get enterPasswordHint {
    return Intl.message(
      'Enter your password',
      name: 'enterPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get loginButton {
    return Intl.message('LOGIN', name: 'loginButton', desc: '', args: []);
  }

  /// `Or`
  String get orDivider {
    return Intl.message('Or', name: 'orDivider', desc: '', args: []);
  }

  /// `Google`
  String get googleLogin {
    return Intl.message('Google', name: 'googleLogin', desc: '', args: []);
  }

  /// `Apple`
  String get appleLogin {
    return Intl.message('Apple', name: 'appleLogin', desc: '', args: []);
  }

  /// `Don't have an account? `
  String get noAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Please enter your username`
  String get usernameValidationError {
    return Intl.message(
      'Please enter your username',
      name: 'usernameValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get passwordValidationError {
    return Intl.message(
      'Please enter your password',
      name: 'passwordValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Tudy App`
  String get tudyAppTitle {
    return Intl.message('Tudy App', name: 'tudyAppTitle', desc: '', args: []);
  }

  /// `Error List`
  String get errorDialogTitle {
    return Intl.message(
      'Error List',
      name: 'errorDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Error Code`
  String get errorCodeHeader {
    return Intl.message(
      'Error Code',
      name: 'errorCodeHeader',
      desc: '',
      args: [],
    );
  }

  /// `Error Message`
  String get errorMessageHeader {
    return Intl.message(
      'Error Message',
      name: 'errorMessageHeader',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get closeButton {
    return Intl.message('Close', name: 'closeButton', desc: '', args: []);
  }

  /// `N/A`
  String get notAvailable {
    return Intl.message('N/A', name: 'notAvailable', desc: '', args: []);
  }

  /// `An error occurred`
  String get generalErrorOccurred {
    return Intl.message(
      'An error occurred',
      name: 'generalErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Login successful! Welcome back!`
  String get loginSuccessMessage {
    return Intl.message(
      'Login successful! Welcome back!',
      name: 'loginSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful! Welcome aboard!`
  String get registrationSuccessMessage {
    return Intl.message(
      'Registration successful! Welcome aboard!',
      name: 'registrationSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed! Please try again.`
  String get registrationFailedMessage {
    return Intl.message(
      'Registration failed! Please try again.',
      name: 'registrationFailedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get emailValidationErrorEmpty {
    return Intl.message(
      'Please enter your email',
      name: 'emailValidationErrorEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get emailValidationErrorInvalid {
    return Intl.message(
      'Please enter a valid email',
      name: 'emailValidationErrorInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get phoneValidationErrorEmpty {
    return Intl.message(
      'Please enter your phone number',
      name: 'phoneValidationErrorEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get phoneValidationErrorInvalid {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'phoneValidationErrorInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your full name`
  String get fullNameValidationErrorEmpty {
    return Intl.message(
      'Please enter your full name',
      name: 'fullNameValidationErrorEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Phone Number`
  String get phone {
    return Intl.message('Phone Number', name: 'phone', desc: '', args: []);
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Enter your email`
  String get enterEmailHint {
    return Intl.message(
      'Enter your email',
      name: 'enterEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enterPhoneNumberHint {
    return Intl.message(
      'Enter your phone number',
      name: 'enterPhoneNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter your full name`
  String get enterFullNameHint {
    return Intl.message(
      'Enter your full name',
      name: 'enterFullNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long`
  String get passwordValidationErrorLength {
    return Intl.message(
      'Password must be at least 8 characters long',
      name: 'passwordValidationErrorLength',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your confirm password`
  String get enterConfirmPasswordHint {
    return Intl.message(
      'Enter your confirm password',
      name: 'enterConfirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your confirm password`
  String get confirmPasswordValidationErrorEmpty {
    return Intl.message(
      'Please enter your confirm password',
      name: 'confirmPasswordValidationErrorEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `REGISTER`
  String get registerButton {
    return Intl.message('REGISTER', name: 'registerButton', desc: '', args: []);
  }

  /// `Already have an account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Username has invalid length (maximum 50)`
  String get usernameValidationErrorLength {
    return Intl.message(
      'Username has invalid length (maximum 50)',
      name: 'usernameValidationErrorLength',
      desc: '',
      args: [],
    );
  }

  /// `Username contains invalid characters (a-z, A-Z) and numbers (0-9) and _`
  String get usernameValidationErrorChars {
    return Intl.message(
      'Username contains invalid characters (a-z, A-Z) and numbers (0-9) and _',
      name: 'usernameValidationErrorChars',
      desc: '',
      args: [],
    );
  }

  /// `Full name must contain at least 2 words`
  String get fullNameValidationErrorMinWords {
    return Intl.message(
      'Full name must contain at least 2 words',
      name: 'fullNameValidationErrorMinWords',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character`
  String get passwordValidationErrorComplexity {
    return Intl.message(
      'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character',
      name: 'passwordValidationErrorComplexity',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
