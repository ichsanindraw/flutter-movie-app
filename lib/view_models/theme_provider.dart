import 'package:flutter_movie_app/enums/theme_enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeEnums>(
  (_) => ThemeProvider(),
);

class ThemeProvider extends StateNotifier<ThemeEnums> {
  final String themeKey = "is_dark_mode_key";

  ThemeProvider() : super(ThemeEnums.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isDarkMode = prefs.getBool(themeKey) ?? true;

    state = isDarkMode ? ThemeEnums.dark : ThemeEnums.light;
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();

    state = state == ThemeEnums.light ? ThemeEnums.dark : ThemeEnums.light;
    await prefs.setBool(themeKey, state == ThemeEnums.dark);
  }
}
