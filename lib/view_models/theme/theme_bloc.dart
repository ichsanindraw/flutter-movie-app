import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final String themeKey = "is_dark_mode";

  ThemeBloc() : super(LightThemeState()) {
    on<LoadThemeEvent>(_loadTheme);

    on<ToggleThemeEvent>(_toggleTheme);
  }

  Future<void> _loadTheme(
    LoadThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = prefs.getBool(themeKey) ?? false;

      if (isDarkMode) {
        emit(DarkThemeState());
      } else {
        emit(LightThemeState());
      }
    } catch (e) {
      emit(ThemeError("failed to load theme ${e.toString()}"));
    }
  }

  Future<void> _toggleTheme(event, emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (state is DarkThemeState) {
        emit(LightThemeState());

        prefs.setBool(themeKey, false);
      } else if (state is LightThemeState) {
        emit(DarkThemeState());

        prefs.setBool(themeKey, true);
      }
    } catch (e) {
      emit(ThemeError("failed to toggle theme ${e.toString()}"));
    }
  }
}
