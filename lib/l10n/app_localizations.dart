import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @enterUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get enterUsernameHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPasswordHint;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'LOGIN'**
  String get loginButton;

  /// No description provided for @orDivider.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get orDivider;

  /// No description provided for @googleLogin.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get googleLogin;

  /// No description provided for @appleLogin.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get appleLogin;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get noAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @usernameValidationError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your username'**
  String get usernameValidationError;

  /// No description provided for @passwordValidationError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordValidationError;

  /// No description provided for @tudyAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Tudy App'**
  String get tudyAppTitle;

  /// No description provided for @errorDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Error List'**
  String get errorDialogTitle;

  /// No description provided for @errorCodeHeader.
  ///
  /// In en, this message translates to:
  /// **'Error Code'**
  String get errorCodeHeader;

  /// No description provided for @errorMessageHeader.
  ///
  /// In en, this message translates to:
  /// **'Error Message'**
  String get errorMessageHeader;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get notAvailable;

  /// No description provided for @generalErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get generalErrorOccurred;

  /// No description provided for @loginSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Login successful! Welcome back!'**
  String get loginSuccessMessage;

  /// No description provided for @registrationSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Registration successful! Welcome aboard!'**
  String get registrationSuccessMessage;

  /// No description provided for @registrationFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Registration failed! Please try again.'**
  String get registrationFailedMessage;

  /// No description provided for @emailValidationErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailValidationErrorEmpty;

  /// No description provided for @emailValidationErrorInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailValidationErrorInvalid;

  /// No description provided for @phoneValidationErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get phoneValidationErrorEmpty;

  /// No description provided for @phoneValidationErrorInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get phoneValidationErrorInvalid;

  /// No description provided for @fullNameValidationErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get fullNameValidationErrorEmpty;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmailHint;

  /// No description provided for @enterPhoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhoneNumberHint;

  /// No description provided for @enterFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullNameHint;

  /// No description provided for @passwordValidationErrorLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get passwordValidationErrorLength;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @enterConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your confirm password'**
  String get enterConfirmPasswordHint;

  /// No description provided for @confirmPasswordValidationErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your confirm password'**
  String get confirmPasswordValidationErrorEmpty;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'REGISTER'**
  String get registerButton;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @usernameValidationErrorLength.
  ///
  /// In en, this message translates to:
  /// **'Username has invalid length (maximum 50)'**
  String get usernameValidationErrorLength;

  /// No description provided for @usernameValidationErrorChars.
  ///
  /// In en, this message translates to:
  /// **'Username contains invalid characters (a-z, A-Z) and numbers (0-9) and _'**
  String get usernameValidationErrorChars;

  /// No description provided for @fullNameValidationErrorMinWords.
  ///
  /// In en, this message translates to:
  /// **'Full name must contain at least 2 words'**
  String get fullNameValidationErrorMinWords;

  /// No description provided for @passwordValidationErrorComplexity.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character'**
  String get passwordValidationErrorComplexity;

  /// Title for the Search screen AppBar and label for the Search tab in BottomNavBar
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// Hint text displayed in the search bar
  ///
  /// In en, this message translates to:
  /// **'Tasks, Projects, and More'**
  String get searchHint;

  /// Section title for recently accessed views/filters
  ///
  /// In en, this message translates to:
  /// **'Recently Viewed'**
  String get recentlyViewed;

  /// Label for the Upcoming tasks view/filter and BottomNavBar tab
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// Label for the Today tasks view/filter, BottomNavBar tab, and default date button
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Label for the Inbox view/filter and default project
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get inbox;

  /// Label for the Browse tab in the BottomNavBar
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get browse;

  /// Tooltip for the Floating Action Button used to add a new task
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTaskTooltip;

  /// Hint text for the task name input field in the add task sheet
  ///
  /// In en, this message translates to:
  /// **'e.g., Discuss thesis tomorrow morning p2'**
  String get addTaskHint;

  /// Hint text for the task description input field in the add task sheet
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionHint;

  /// Label for the date selection button in the add task sheet
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Label for the priority selection button in the add task sheet
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// Label for the reminders selection button in the add task sheet
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// Tooltip for the 'more options' button in the add task sheet
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get moreOptions;

  /// Error message shown when the task name is empty on submission
  ///
  /// In en, this message translates to:
  /// **'Please enter a task name'**
  String get taskNameValidationErrorEmpty;

  /// Action label/,tooltip for submitting the new task (distinct from FAB tooltip)
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get submitTask;

  /// Label for priority level 1
  ///
  /// In en, this message translates to:
  /// **'Priority 1'**
  String get priority1;

  /// Label for priority level 2
  ///
  /// In en, this message translates to:
  /// **'Priority 2'**
  String get priority2;

  /// Label for priority level 3
  ///
  /// In en, this message translates to:
  /// **'Priority 3'**
  String get priority3;

  /// Label for priority level 4 (often default)
  ///
  /// In en, this message translates to:
  /// **'Priority 4'**
  String get priority4;

  /// Message displayed when no tasks are found in a specific view/filter
  ///
  /// In en, this message translates to:
  /// **'No tasks found'**
  String get noTaskFound;

  /// Label for the Tomorrow tasks view/filter and default date button
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// Label for the time selection button in the add task sheet
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// Label for the OK button in dialogs and confirmation messages
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Label for the Cancel button in dialogs and confirmation messages
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Label for the date selection button in the add task sheet
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// Label for the button to customize task priorities in the settings screen
  ///
  /// In en, this message translates to:
  /// **'Customize Priorities'**
  String get customizePriorities;

  /// Label for the button to manage task categories in the settings screen
  ///
  /// In en, this message translates to:
  /// **'Manage Categories'**
  String get manageCategories;

  /// Label for the time selection button in the add task sheet
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// Label for the 'None' option in various selection contexts
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// Label for the 'Done' option in various selection contexts
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Label for the 'Next Week' option in various selection contexts
  ///
  /// In en, this message translates to:
  /// **'Next Week'**
  String get nextWeek;

  /// Label for the 'No Date' option in various selection contexts
  ///
  /// In en, this message translates to:
  /// **'No Date'**
  String get noDate;

  /// Label for the button to create a new category in the settings screen
  ///
  /// In en, this message translates to:
  /// **'Create New Category'**
  String get createNewCategory;

  /// Hint text for the category name input field in the create new category dialog
  ///
  /// In en, this message translates to:
  /// **'Enter category name'**
  String get categoryNameHint;

  /// Label for the button to create a new category in the create new category dialog
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// Message displayed when there are no tasks in the current view/filter
  ///
  /// In en, this message translates to:
  /// **'No tasks yet'**
  String get noTasksYet;

  /// Label for the button to set a reminder for a task
  ///
  /// In en, this message translates to:
  /// **'Set Reminder'**
  String get setReminder;

  /// Label for the reminder setting in the add task sheet
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get reminder;

  /// Label for the daily repeat option in the reminder settings
  ///
  /// In en, this message translates to:
  /// **'Repeats Daily'**
  String get repeatsDaily;

  /// Label for the time selection button in the reminder settings
  ///
  /// In en, this message translates to:
  /// **'Select Reminder Time'**
  String get selectReminderTime;

  /// Label for the repeat reminder option in the reminder settings
  ///
  /// In en, this message translates to:
  /// **'Repeat Reminder'**
  String get repeatReminder;

  /// Label for the button to remove a reminder from a task
  ///
  /// In en, this message translates to:
  /// **'Remove Reminder'**
  String get removeReminder;

  /// Short label for daily reminders
  ///
  /// In en, this message translates to:
  /// **'D'**
  String get dailyShort;

  /// Label for the Yesterday tasks view/filter and default date button
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// General error message displayed in various contexts
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorGeneral;

  /// Error message displayed when task creation fails
  ///
  /// In en, this message translates to:
  /// **'Error creating task'**
  String get errorCreatingTask;

  /// Label for the button to add a new task
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTask;

  /// Message displayed when there are no upcoming tasks
  ///
  /// In en, this message translates to:
  /// **'No upcoming tasks'**
  String get noUpcomingTasks;

  /// Label for the language selection option in the settings screen
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Label for the button to delete the user account in the settings screen
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// Confirmation message displayed when the user attempts to delete their account
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get deleteAccountConfirmation;

  /// Label for the button to delete a task or account
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Message displayed when the account deletion request is sent
  ///
  /// In en, this message translates to:
  /// **'Account deletion request sent. Please check your email for confirmation.'**
  String get deleteAccountRequestSentPlaceholder;

  /// Label for the button to log out of the application
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Confirmation message displayed when the user attempts to log out
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmation;

  /// Error message displayed when login fails
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your credentials.'**
  String get loginFailedError;

  /// General error message displayed during login
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred during login'**
  String get loginGeneralError;

  /// Error message displayed when Google sign-in fails
  ///
  /// In en, this message translates to:
  /// **'Error signing in with Google'**
  String get googleSignInError;

  /// Error message displayed when Apple sign-in fails
  ///
  /// In en, this message translates to:
  /// **'Error signing in with Apple'**
  String get appleSignInError;

  /// Error message displayed when Apple sign-in is not available
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple is not available on this device'**
  String get appleSignInNotAvailable;

  /// Error message displayed when social login fails
  ///
  /// In en, this message translates to:
  /// **'Social login failed.'**
  String get socialLoginFailedError;

  /// General error message displayed during social login
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred during social login'**
  String get socialLoginGeneralError;

  /// Error message displayed when logout fails
  ///
  /// In en, this message translates to:
  /// **'Failed to log out'**
  String get logoutError;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
