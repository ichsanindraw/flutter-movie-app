import 'package:flutter/material.dart';
import 'package:flutter_movie_app/models/genre/genre_model.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/repository/movies_repo.dart';
import 'package:flutter_movie_app/service/init_getit.dart';

class MovieProvider with ChangeNotifier {
  int currentPage = 1;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  List<GenreModel> _genres = [];
  List<GenreModel> get genres => _genres;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorGetMovies = "";
  String get errorGetMovies => _errorGetMovies;

  final MoviesRepo _moviesRepo = getIt<MoviesRepo>();

  Future<void> getMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_genres.isEmpty) {
        _genres = await _moviesRepo.getGenres();
      }

      MovieListModel movieList = await _moviesRepo.getMovies(page: currentPage);
      _movies.addAll(movieList.results);

      currentPage++;
      _errorGetMovies = "";
    } catch (e) {
      _errorGetMovies = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
