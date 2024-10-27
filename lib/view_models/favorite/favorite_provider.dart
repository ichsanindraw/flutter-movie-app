import 'dart:convert';

import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/view_models/favorite/favorite_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoriteProvider =
    StateNotifierProvider<FavoritesProvider, FavoriteState>(
  (_) => FavoritesProvider(),
);

class FavoritesProvider extends StateNotifier<FavoriteState> {
  final String _favoriteKeys = "favorites_key";

  FavoritesProvider() : super(FavoriteState());

  bool isFavorite(MovieModel movieModel) {
    return state.favoriteMovies.any((movie) => movie.id == movieModel.id);
  }

  void addOrRemoveFromFavorites(MovieModel movieModel) async {
    bool wasFavorite = isFavorite(movieModel);

    List<MovieModel> updatedFavorites = wasFavorite
        ? state.favoriteMovies
            .where((element) => element.id != movieModel.id)
            .toList()
        : [...state.favoriteMovies, movieModel];

    state = state.copyWith(favMovies: updatedFavorites);

    await _saveFavorites();
  }

  void clearAllFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_favoriteKeys);

    state = state.copyWith(favMovies: []);
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> stringList = state.favoriteMovies
        .map((movie) => jsonEncode(movie.toJson()))
        .toList();

    prefs.setStringList(_favoriteKeys, stringList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> stringList = prefs.getStringList(_favoriteKeys) ?? [];

    final movies = stringList
        .map(
          (movie) => MovieModel.fromJson(json.decode(movie)),
        )
        .toList();

    state = state.copyWith(favMovies: movies);
  }
}
