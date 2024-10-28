import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/widgets/movies/movie_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final String favoriteKeys = "favorites_keys";

  FavoriteBloc() : super(FavoriteInitial()) {
    on<LoadFavorites>(_loadFavorites);

    on<AddToFavorites>(_addToFavorites);

    on<RemoveFromFavorites>(_removeFromFavorites);

    on<RemoveAllFavorites>(_removeAllFavorites);
  }

  Future<void> _loadFavorites(event, emit) async {
    emit(FavoriteLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final stringList = prefs.getStringList(favoriteKeys) ?? [];
      final favorites = stringList
          .map((movie) => MovieModel.fromJson(json.decode(movie)))
          .toList();

      emit(FavoriteLoaded(favorites));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> _addToFavorites(
    AddToFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    if (state is FavoriteLoaded) {
      List<MovieModel> updatedFavorites =
          List.from((state as FavoriteLoaded).favorites)..add(event.movie);

      emit(FavoriteLoaded(updatedFavorites));
      await _saveFavorite(updatedFavorites);
    }
  }

  Future<void> _removeFromFavorites(
    RemoveFromFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    if (state is FavoriteLoaded) {
      List<MovieModel> updatedFavorites = (state as FavoriteLoaded)
          .favorites
          .where((movie) => movie.id != event.movie.id)
          .toList();

      emit(FavoriteLoaded(updatedFavorites));
      await _saveFavorite(updatedFavorites);
    }
  }

  Future<void> _removeAllFavorites(event, emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(favoriteKeys);

      emit(const FavoriteLoaded([]));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> _saveFavorite(List<MovieModel> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final stringList =
        favorites.map((movie) => json.encode(movie.toJson())).toList();

    prefs.setStringList(favoriteKeys, stringList);
  }

  bool isFavorite(MovieModel movieModel) {
    if (state is FavoriteLoaded) {
      return (state as FavoriteLoaded)
          .favorites
          .any((movie) => movie.id == movieModel.id);
    }

    return false;
  }
}
