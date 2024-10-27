import 'package:flutter_movie_app/models/movie/movie_model.dart';

class FavoriteState {
  final List<MovieModel> favoriteMovies;

  FavoriteState({
    this.favoriteMovies = const [],
  });

  FavoriteState copyWith({
    List<MovieModel>? favMovies,
  }) {
    return FavoriteState(
      favoriteMovies: favMovies ?? this.favoriteMovies,
    );
  }
}
