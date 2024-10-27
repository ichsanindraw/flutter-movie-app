part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

// final class ThemeInitial extends ThemeState {}

final class LightThemeState extends ThemeState {
  final ThemeData themeData = AppTheme.lightTheme;
}

final class DarkThemeState extends ThemeState {
  final ThemeData themeData = AppTheme.darkTheme;
}

final class ThemeError extends ThemeState {
  final String message;

  const ThemeError(this.message);
}
