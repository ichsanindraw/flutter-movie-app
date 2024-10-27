import 'dart:developer';

import 'package:flutter_movie_app/models/genre/genre_model.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';

abstract class MovieViewState {}

class MovieLoading extends MovieViewState {}

class MovieSuccess extends MovieViewState {
  final List<MovieModel> movies;

  MovieSuccess(this.movies);
}

class MovieError extends MovieViewState {
  final String message;
  MovieError(this.message);
}

class MovieState {
  final int currentPage;
  final List<MovieModel> movies;
  final List<GenreModel> genres;
  final bool isLoading;
  final String errorMessage;

  MovieState({
    this.currentPage = 1,
    this.movies = const [],
    this.genres = const [],
    this.isLoading = false,
    this.errorMessage = "",
  });

  MovieState copyWith({
    int? currentPage,
    List<MovieModel>? movies,
    List<GenreModel>? genres,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MovieState(
      currentPage: currentPage ?? this.currentPage,
      movies: movies ?? this.movies,
      genres: genres ?? this.genres,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
