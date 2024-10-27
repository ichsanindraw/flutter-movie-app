import 'package:flutter_movie_app/models/genre/genre_model.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/repository/movies_repo.dart';
import 'package:flutter_movie_app/service/init_getit.dart';
import 'package:flutter_movie_app/view_models/movie/movie_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieProvider = StateNotifierProvider<MovieProvider, MovieState>(
  (_) => MovieProvider(),
);

final currentMovie = Provider.family<MovieModel, int>(
  (ref, index) {
    final movisState = ref.watch(movieProvider);
    return movisState.movies[index];
  },
);

class MovieProvider extends StateNotifier<MovieState> {
  MovieProvider() : super(MovieState());

  final MoviesRepo _movieRepo = getIt<MoviesRepo>();

  Future<void> getMovies() async {
    state = state.copyWith(isLoading: true);

    try {
      if (state.genres.isEmpty) {
        final List<GenreModel> genres = await _movieRepo.getGenres();
        state.copyWith(genres: genres);
      }

      MovieListModel movieList =
          await _movieRepo.getMovies(page: state.currentPage);
      List<MovieModel> movies = movieList.results;

      state = state.copyWith(
        currentPage: state.currentPage + 1,
        movies: [...state.movies, ...movies],
        isLoading: false,
        errorMessage: "",
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }
}
