import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeMode = AppTheme.lightTheme;

  ThemeData get themeData => _themeMode;

  final String themeKey = "is_dark_mode_key";

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(themeKey) ?? false;
    _themeMode = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = _themeMode == AppTheme.darkTheme
        ? AppTheme.lightTheme
        : AppTheme.darkTheme;

    await prefs.setBool(themeKey, _themeMode == AppTheme.darkTheme);
    notifyListeners();
  }
}
