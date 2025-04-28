// File: lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Key for storing theme preference
const String _themeModeKey = 'user_theme_mode';

// Map ThemeMode to a String for SharedPreferences
String? _themeModeToString(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.system:
      return 'system';
    case ThemeMode.light:
      return 'light';
    case ThemeMode.dark:
      return 'dark';
  }
}

// Map String from SharedPreferences back to ThemeMode
ThemeMode _stringToThemeMode(String? modeString) {
  switch (modeString) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    case 'system':
    default: // Default to system if null or unknown
      return ThemeMode.system;
  }
}

// StateNotifierProvider for the application's theme mode
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    // Default to system
    _loadThemeMode();
  }

  // Load the saved theme mode from SharedPreferences
  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedModeString = prefs.getString(_themeModeKey);
    state =
        _stringToThemeMode(savedModeString); // Update state with loaded value
  }

  // Set a new theme mode and save to SharedPreferences
  Future<void> setThemeMode(ThemeMode mode) async {
    if (state != mode) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          _themeModeKey, _themeModeToString(mode)!); // Save preference
      state = mode; // Update state, triggers rebuild
    }
  }
}
