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

  /// `Search`
  String get searchTitle {
    return Intl.message(
      'Search',
      name: 'searchTitle',
      desc:
          'Title for the Search screen AppBar and label for the Search tab in BottomNavBar',
      args: [],
    );
  }

  /// `Tasks, Projects, and More`
  String get searchHint {
    return Intl.message(
      'Tasks, Projects, and More',
      name: 'searchHint',
      desc: 'Hint text displayed in the search bar',
      args: [],
    );
  }

  /// `Recently Viewed`
  String get recentlyViewed {
    return Intl.message(
      'Recently Viewed',
      name: 'recentlyViewed',
      desc: 'Section title for recently accessed views/filters',
      args: [],
    );
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message(
      'Upcoming',
      name: 'upcoming',
      desc: 'Label for the Upcoming tasks view/filter and BottomNavBar tab',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc:
          'Label for the Today tasks view/filter, BottomNavBar tab, and default date button',
      args: [],
    );
  }

  /// `Inbox`
  String get inbox {
    return Intl.message(
      'Inbox',
      name: 'inbox',
      desc: 'Label for the Inbox view/filter and default project',
      args: [],
    );
  }

  /// `Browse`
  String get browse {
    return Intl.message(
      'Browse',
      name: 'browse',
      desc: 'Label for the Browse tab in the BottomNavBar',
      args: [],
    );
  }

  /// `Add Task`
  String get addTaskTooltip {
    return Intl.message(
      'Add Task',
      name: 'addTaskTooltip',
      desc: 'Tooltip for the Floating Action Button used to add a new task',
      args: [],
    );
  }

  /// `e.g., Discuss thesis tomorrow morning p2`
  String get addTaskHint {
    return Intl.message(
      'e.g., Discuss thesis tomorrow morning p2',
      name: 'addTaskHint',
      desc: 'Hint text for the task name input field in the add task sheet',
      args: [],
    );
  }

  /// `Description`
  String get descriptionHint {
    return Intl.message(
      'Description',
      name: 'descriptionHint',
      desc:
          'Hint text for the task description input field in the add task sheet',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: 'Label for the date selection button in the add task sheet',
      args: [],
    );
  }

  /// `Priority`
  String get priority {
    return Intl.message(
      'Priority',
      name: 'priority',
      desc: 'Label for the priority selection button in the add task sheet',
      args: [],
    );
  }

  /// `Reminders`
  String get reminders {
    return Intl.message(
      'Reminders',
      name: 'reminders',
      desc: 'Label for the reminders selection button in the add task sheet',
      args: [],
    );
  }

  /// `More options`
  String get moreOptions {
    return Intl.message(
      'More options',
      name: 'moreOptions',
      desc: 'Tooltip for the \'more options\' button in the add task sheet',
      args: [],
    );
  }

  /// `Please enter a task name`
  String get taskNameValidationErrorEmpty {
    return Intl.message(
      'Please enter a task name',
      name: 'taskNameValidationErrorEmpty',
      desc: 'Error message shown when the task name is empty on submission',
      args: [],
    );
  }

  /// `Add Task`
  String get submitTask {
    return Intl.message(
      'Add Task',
      name: 'submitTask',
      desc:
          'Action label/,tooltip for submitting the new task (distinct from FAB tooltip)',
      args: [],
    );
  }

  /// `Priority 1`
  String get priority1 {
    return Intl.message(
      'Priority 1',
      name: 'priority1',
      desc: 'Label for priority level 1',
      args: [],
    );
  }

  /// `Priority 2`
  String get priority2 {
    return Intl.message(
      'Priority 2',
      name: 'priority2',
      desc: 'Label for priority level 2',
      args: [],
    );
  }

  /// `Priority 3`
  String get priority3 {
    return Intl.message(
      'Priority 3',
      name: 'priority3',
      desc: 'Label for priority level 3',
      args: [],
    );
  }

  /// `Priority 4`
  String get priority4 {
    return Intl.message(
      'Priority 4',
      name: 'priority4',
      desc: 'Label for priority level 4 (often default)',
      args: [],
    );
  }

  /// `No tasks found`
  String get noTaskFound {
    return Intl.message(
      'No tasks found',
      name: 'noTaskFound',
      desc:
          'Message displayed when no tasks are found in a specific view/filter',
      args: [],
    );
  }

  /// `Tomorrow`
  String get tomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'tomorrow',
      desc: 'Label for the Tomorrow tasks view/filter and default date button',
      args: [],
    );
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message(
      'Select Time',
      name: 'selectTime',
      desc: 'Label for the time selection button in the add task sheet',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: 'Label for the OK button in dialogs and confirmation messages',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Label for the Cancel button in dialogs and confirmation messages',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message(
      'Select Date',
      name: 'selectDate',
      desc: 'Label for the date selection button in the add task sheet',
      args: [],
    );
  }

  /// `Customize Priorities`
  String get customizePriorities {
    return Intl.message(
      'Customize Priorities',
      name: 'customizePriorities',
      desc:
          'Label for the button to customize task priorities in the settings screen',
      args: [],
    );
  }

  /// `Manage Categories`
  String get manageCategories {
    return Intl.message(
      'Manage Categories',
      name: 'manageCategories',
      desc:
          'Label for the button to manage task categories in the settings screen',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: 'Label for the time selection button in the add task sheet',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: 'Label for the \'None\' option in various selection contexts',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: 'Label for the \'Done\' option in various selection contexts',
      args: [],
    );
  }

  /// `Next Week`
  String get nextWeek {
    return Intl.message(
      'Next Week',
      name: 'nextWeek',
      desc: 'Label for the \'Next Week\' option in various selection contexts',
      args: [],
    );
  }

  /// `No Date`
  String get noDate {
    return Intl.message(
      'No Date',
      name: 'noDate',
      desc: 'Label for the \'No Date\' option in various selection contexts',
      args: [],
    );
  }

  /// `Create New Category`
  String get createNewCategory {
    return Intl.message(
      'Create New Category',
      name: 'createNewCategory',
      desc:
          'Label for the button to create a new category in the settings screen',
      args: [],
    );
  }

  /// `Enter category name`
  String get categoryNameHint {
    return Intl.message(
      'Enter category name',
      name: 'categoryNameHint',
      desc:
          'Hint text for the category name input field in the create new category dialog',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc:
          'Label for the button to create a new category in the create new category dialog',
      args: [],
    );
  }

  /// `No tasks yet`
  String get noTasksYet {
    return Intl.message(
      'No tasks yet',
      name: 'noTasksYet',
      desc:
          'Message displayed when there are no tasks in the current view/filter',
      args: [],
    );
  }

  /// `Set Reminder`
  String get setReminder {
    return Intl.message(
      'Set Reminder',
      name: 'setReminder',
      desc: 'Label for the button to set a reminder for a task',
      args: [],
    );
  }

  /// `Reminder`
  String get reminder {
    return Intl.message(
      'Reminder',
      name: 'reminder',
      desc: 'Label for the reminder setting in the add task sheet',
      args: [],
    );
  }

  /// `Repeats Daily`
  String get repeatsDaily {
    return Intl.message(
      'Repeats Daily',
      name: 'repeatsDaily',
      desc: 'Label for the daily repeat option in the reminder settings',
      args: [],
    );
  }

  /// `Select Reminder Time`
  String get selectReminderTime {
    return Intl.message(
      'Select Reminder Time',
      name: 'selectReminderTime',
      desc: 'Label for the time selection button in the reminder settings',
      args: [],
    );
  }

  /// `Repeat Reminder`
  String get repeatReminder {
    return Intl.message(
      'Repeat Reminder',
      name: 'repeatReminder',
      desc: 'Label for the repeat reminder option in the reminder settings',
      args: [],
    );
  }

  /// `Remove Reminder`
  String get removeReminder {
    return Intl.message(
      'Remove Reminder',
      name: 'removeReminder',
      desc: 'Label for the button to remove a reminder from a task',
      args: [],
    );
  }

  /// `D`
  String get dailyShort {
    return Intl.message(
      'D',
      name: 'dailyShort',
      desc: 'Short label for daily reminders',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: 'Label for the Yesterday tasks view/filter and default date button',
      args: [],
    );
  }

  /// `An error occurred`
  String get errorGeneral {
    return Intl.message(
      'An error occurred',
      name: 'errorGeneral',
      desc: 'General error message displayed in various contexts',
      args: [],
    );
  }

  /// `Error creating task`
  String get errorCreatingTask {
    return Intl.message(
      'Error creating task',
      name: 'errorCreatingTask',
      desc: 'Error message displayed when task creation fails',
      args: [],
    );
  }

  /// `Add Task`
  String get addTask {
    return Intl.message(
      'Add Task',
      name: 'addTask',
      desc: 'Label for the button to add a new task',
      args: [],
    );
  }

  /// `No upcoming tasks`
  String get noUpcomingTasks {
    return Intl.message(
      'No upcoming tasks',
      name: 'noUpcomingTasks',
      desc: 'Message displayed when there are no upcoming tasks',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: 'Label for the language selection option in the settings screen',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc:
          'Label for the button to delete the user account in the settings screen',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? This action cannot be undone.`
  String get deleteAccountConfirmation {
    return Intl.message(
      'Are you sure you want to delete your account? This action cannot be undone.',
      name: 'deleteAccountConfirmation',
      desc:
          'Confirmation message displayed when the user attempts to delete their account',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: 'Label for the button to delete a task or account',
      args: [],
    );
  }

  /// `Account deletion request sent. Please check your email for confirmation.`
  String get deleteAccountRequestSentPlaceholder {
    return Intl.message(
      'Account deletion request sent. Please check your email for confirmation.',
      name: 'deleteAccountRequestSentPlaceholder',
      desc: 'Message displayed when the account deletion request is sent',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: 'Label for the button to log out of the application',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get logoutConfirmation {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logoutConfirmation',
      desc: 'Confirmation message displayed when the user attempts to log out',
      args: [],
    );
  }

  /// `Login failed. Please check your credentials.`
  String get loginFailedError {
    return Intl.message(
      'Login failed. Please check your credentials.',
      name: 'loginFailedError',
      desc: 'Error message displayed when login fails',
      args: [],
    );
  }

  /// `An unexpected error occurred during login`
  String get loginGeneralError {
    return Intl.message(
      'An unexpected error occurred during login',
      name: 'loginGeneralError',
      desc: 'General error message displayed during login',
      args: [],
    );
  }

  /// `Error signing in with Google`
  String get googleSignInError {
    return Intl.message(
      'Error signing in with Google',
      name: 'googleSignInError',
      desc: 'Error message displayed when Google sign-in fails',
      args: [],
    );
  }

  /// `Error signing in with Apple`
  String get appleSignInError {
    return Intl.message(
      'Error signing in with Apple',
      name: 'appleSignInError',
      desc: 'Error message displayed when Apple sign-in fails',
      args: [],
    );
  }

  /// `Sign in with Apple is not available on this device`
  String get appleSignInNotAvailable {
    return Intl.message(
      'Sign in with Apple is not available on this device',
      name: 'appleSignInNotAvailable',
      desc: 'Error message displayed when Apple sign-in is not available',
      args: [],
    );
  }

  /// `Social login failed.`
  String get socialLoginFailedError {
    return Intl.message(
      'Social login failed.',
      name: 'socialLoginFailedError',
      desc: 'Error message displayed when social login fails',
      args: [],
    );
  }

  /// `An unexpected error occurred during social login`
  String get socialLoginGeneralError {
    return Intl.message(
      'An unexpected error occurred during social login',
      name: 'socialLoginGeneralError',
      desc: 'General error message displayed during social login',
      args: [],
    );
  }

  /// `Failed to log out`
  String get logoutError {
    return Intl.message(
      'Failed to log out',
      name: 'logoutError',
      desc: 'Error message displayed when logout fails',
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
