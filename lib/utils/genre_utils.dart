import 'package:flutter/material.dart';
import 'package:flutter_movie_app/models/genre/genre_model.dart';
import 'package:flutter_movie_app/view_models/movie_provider.dart';
import 'package:provider/provider.dart';

class GenreUtils {
  static List<GenreModel> movieGenresName(
      List<int> genreIds, BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final cacheGenres = movieProvider.genres;

    List<GenreModel> genresNames = [];

    for (var genreId in genreIds) {
      var genre = cacheGenres.firstWhere(
        (g) => g.id == genreId,
        orElse: () => GenreModel(id: 12345, name: "Unknown"),
      );

      genresNames.add(genre);
    }

    return genresNames;
  }
}
