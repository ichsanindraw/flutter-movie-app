import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie_app/models/genre/genre_model.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/repository/movies_repo.dart';
import 'package:flutter_movie_app/service/init_getit.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MoviesRepo _repo = getIt<MoviesRepo>();

  MovieBloc() : super(MovieInitial()) {
    on<GetMoviesEvent>(_getMovies);
    on<LoadMoreEvent>(_loadMore);
  }

  Future<void> _getMovies(event, emit) async {
    log("_getMovies");
    emit(MovieLoading());

    try {
      int page = 1;

      var genres = await _repo.getGenres();
      var movies = await _repo.getMovies(page: page);

      emit(
        MovieSuccess(
          currentPage: page,
          movies: movies.results,
          genres: genres,
        ),
      );
    } catch (e) {
      emit(MovieError("failed to load movies ${e.toString()}"));
    }
  }

  Future<void> _loadMore(event, emit) async {
    final currentState = state;

    // if (currentState is MovieLoadMore) {
    //   return;
    // }

    emit(const MovieLoadMore());

    if (currentState is MovieSuccess) {
      try {
        int nextPage = currentState.currentPage + 1;

        log("_loadMore: $nextPage");

        var movies = await _repo.getMovies(page: nextPage);

        if (movies.results.isEmpty) {
          emit(currentState);
          return;
        }

        currentState.movies.addAll(movies.results);

        emit(
          MovieSuccess(
            currentPage: nextPage,
            movies: currentState.movies,
            genres: currentState.genres,
          ),
        );
      } catch (e) {
        emit(MovieError("failed to load movies ${e.toString()}"));
      }
    }
  }
}
