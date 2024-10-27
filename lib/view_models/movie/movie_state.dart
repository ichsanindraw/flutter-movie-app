part of 'movie_bloc.dart';

sealed class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState {}

final class MovieSuccess extends MovieState {
  final int currentPage;

  final List<MovieModel> movies;
  final List<GenreModel> genres;

  const MovieSuccess({
    this.currentPage = 1,
    this.movies = const [],
    this.genres = const [],
  });

  MovieSuccess copyWith({
    int? currentPage,
    List<MovieModel>? movies,
    List<GenreModel>? genres,
  }) {
    return MovieSuccess(
      currentPage: currentPage ?? this.currentPage,
      movies: movies ?? this.movies,
      genres: genres ?? this.genres,
    );
  }
}

final class MovieLoadMore extends MovieState {}

// final class MovieLoadMore extends MovieState {
//   final int currentPage;

//   final List<MovieModel> movies;
//   final List<GenreModel> genres;

//   const MovieLoadMore({
//     this.currentPage = 1,
//     this.movies = const [],
//     this.genres = const [],
//   });

//   MovieLoadMore copyWith({
//     int? currentPage,
//     List<MovieModel>? movies,
//     List<GenreModel>? genres,
//   }) {
//     return MovieLoadMore(
//       currentPage: currentPage ?? this.currentPage,
//       movies: movies ?? this.movies,
//       genres: genres ?? this.genres,
//     );
//   }
// }

final class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);
}
