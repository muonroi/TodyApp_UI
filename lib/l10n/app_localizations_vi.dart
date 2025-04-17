// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get login => 'Đăng nhập';

  @override
  String get username => 'Tên đăng nhập';

  @override
  String get enterUsernameHint => 'Nhập tên đăng nhập của bạn';

  @override
  String get password => 'Mật khẩu';

  @override
  String get enterPasswordHint => 'Nhập mật khẩu của bạn';

  @override
  String get loginButton => 'ĐĂNG NHẬP';

  @override
  String get orDivider => 'Hoặc';

  @override
  String get googleLogin => 'Google';

  @override
  String get appleLogin => 'Apple';

  @override
  String get noAccount => 'Chưa có tài khoản? ';

  @override
  String get register => 'Đăng ký';

  @override
  String get usernameValidationError => 'Vui lòng nhập tên đăng nhập';

  @override
  String get passwordValidationError => 'Vui lòng nhập mật khẩu';

  @override
  String get tudyAppTitle => 'Ứng dụng Tudy';

  @override
  String get errorDialogTitle => 'Danh Sách Lỗi';

  @override
  String get errorCodeHeader => 'Mã Lỗi';

  @override
  String get errorMessageHeader => 'Thông Báo Lỗi';

  @override
  String get closeButton => 'Đóng';

  @override
  String get notAvailable => 'Không có';

  @override
  String get generalErrorOccurred => 'Có lỗi xảy ra';

  @override
  String get loginSuccessMessage => 'Đăng nhập thành công! Chào mừng trở lại!';

  @override
  String get registrationSuccessMessage => 'Đăng ký thành công! Chào mừng bạn!';

  @override
  String get registrationFailedMessage => 'Đăng ký không thành công! Vui lòng thử lại.';

  @override
  String get emailValidationErrorEmpty => 'Vui lòng nhập email';

  @override
  String get emailValidationErrorInvalid => 'Vui lòng nhập email hợp lệ';

  @override
  String get phoneValidationErrorEmpty => 'Vui lòng nhập số điện thoại';

  @override
  String get phoneValidationErrorInvalid => 'Vui lòng nhập số điện thoại hợp lệ';

  @override
  String get fullNameValidationErrorEmpty => 'Vui lòng nhập họ tên của bạn';

  @override
  String get email => 'Email';

  @override
  String get phone => 'Số điện thoại';

  @override
  String get fullName => 'Họ tên';

  @override
  String get enterEmailHint => 'Nhập email của bạn';

  @override
  String get enterPhoneNumberHint => 'Nhập số điện thoại của bạn';

  @override
  String get enterFullNameHint => 'Nhập họ tên của bạn';

  @override
  String get passwordValidationErrorLength => 'Mật khẩu phải có ít nhất 6 ký tự';

  @override
  String get confirmPassword => 'Xác nhận mật khẩu';

  @override
  String get enterConfirmPasswordHint => 'Nhập lại mật khẩu của bạn';

  @override
  String get confirmPasswordValidationErrorEmpty => 'Vui lòng xác nhận mật khẩu';

  @override
  String get passwordsDoNotMatch => 'Mật khẩu không khớp';

  @override
  String get registerButton => 'ĐĂNG KÝ';

  @override
  String get alreadyHaveAccount => 'Đã có tài khoản? ';

  @override
  String get usernameValidationErrorLength => 'Tên đăng nhập có độ dài không hợp lệ (<50)';

  @override
  String get usernameValidationErrorChars => 'Username contains invalid characters (a-z, A-Z) and numbers (0-9) and _';

  @override
  String get fullNameValidationErrorMinWords => 'Full name must contain at least 2 words';

  @override
  String get passwordValidationErrorComplexity => 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
}
