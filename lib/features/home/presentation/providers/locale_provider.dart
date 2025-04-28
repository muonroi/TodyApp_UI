// File: lib/providers/locale_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Key để lưu ngôn ngữ trong SharedPreferences
const String _localeKey = 'user_locale';

// StateNotifierProvider cho Locale của ứng dụng
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  // Khởi tạo với một locale mặc định (ví dụ 'en')
  // và sau đó tải locale đã lưu nếu có
  LocaleNotifier() : super(const Locale('en')) {
    _loadLocale();
  }

  // Tải locale đã lưu từ SharedPreferences
  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_localeKey);
    if (languageCode != null) {
      // Cập nhật state nếu tìm thấy locale đã lưu
      // state = Locale(languageCode, countryCode); // Nếu bạn lưu cả countryCode
      state = Locale(languageCode); // Chỉ lưu languageCode cho đơn giản
    } else {
      // Nếu không có locale đã lưu, bạn có thể giữ mặc định ('en')
      // hoặc thử lấy locale của hệ thống: WidgetsBinding.instance.platformDispatcher.locale
      // Giữ mặc định cho ví dụ này
      state = const Locale('en');
    }
  }

  // Đặt locale mới và lưu vào SharedPreferences
  Future<void> setLocale(Locale locale) async {
    // Chỉ cập nhật nếu locale mới khác locale hiện tại
    if (state != locale) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode); // Lưu ngôn ngữ
      // Nếu bạn lưu cả countryCode: await prefs.setString(_localeKey, '${locale.languageCode}_${locale.countryCode ?? ''}');
      state =
          locale; // Cập nhật state, điều này sẽ kích hoạt rebuild widget lắng nghe
    }
  }
}
