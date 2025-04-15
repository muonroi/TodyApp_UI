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
}
