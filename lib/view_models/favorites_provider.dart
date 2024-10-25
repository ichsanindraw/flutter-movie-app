import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  final String _favoriteKeys = "favorites_key";

  final List<MovieModel> _favoritesMovies = [];
  List<MovieModel> get favoritesMovies => _favoritesMovies;

  bool isFavorite(MovieModel movieModel) {
    return _favoritesMovies.any((movie) => movie.id == movieModel.id);
  }

  void addOrRemoveFromFavorites(MovieModel movieModel) async {
    if (isFavorite(movieModel)) {
      _favoritesMovies.removeWhere((movie) => movie.id == movieModel.id);
    } else {
      _favoritesMovies.add(movieModel);
    }

    await _saveFavorites();
    notifyListeners();
  }

  void clearAllFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_favoriteKeys);

    _favoritesMovies.clear();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> stringList =
        _favoritesMovies.map((movie) => jsonEncode(movie.toJson())).toList();

    prefs.setStringList(_favoriteKeys, stringList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> stringList = prefs.getStringList(_favoriteKeys) ?? [];

    _favoritesMovies.clear();
    _favoritesMovies.addAll(
      stringList.map(
        (movie) => MovieModel.fromJson(json.decode(movie)),
      ),
    );
    notifyListeners();
  }
}
