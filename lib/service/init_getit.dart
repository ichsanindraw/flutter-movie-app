import 'package:flutter_movie_app/repository/movies_repo.dart';
import 'package:flutter_movie_app/service/navigation_service.dart';
import 'package:flutter_movie_app/service/network_service.dart';
import 'package:flutter_movie_app/view_models/favorite/favorite_bloc.dart';
import 'package:flutter_movie_app/view_models/movie/movie_bloc.dart';
import 'package:flutter_movie_app/view_models/theme/theme_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<NetworkService>(() => NetworkService());
  getIt.registerLazySingleton<MoviesRepo>(
      () => MoviesRepo(getIt<NetworkService>()));
  getIt.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
  getIt.registerLazySingleton<MovieBloc>(() => MovieBloc());
  getIt.registerLazySingleton<FavoriteBloc>(() => FavoriteBloc());
}
