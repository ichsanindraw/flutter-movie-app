import 'package:flutter_movie_app/models/genre/genre_model.dart';
import 'package:flutter_movie_app/repository/movies_repo.dart';
import 'package:flutter_movie_app/service/init_getit.dart';

class GenreUtils {
  static List<GenreModel> movieGenresName(List<int> genreIds) {
    final movieRepo = getIt<MoviesRepo>();
    final cacheGenres = movieRepo.genres;

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
