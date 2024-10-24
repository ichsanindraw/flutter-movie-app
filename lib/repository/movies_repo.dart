import 'package:flutter_movie_app/constants/app_constants.dart';
import 'package:flutter_movie_app/models/genre/genre_model.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/service/network_service.dart';

abstract class MoviesUseCase {
  Future<MovieListModel> getMovies({int page});

  Future<List<GenreModel>> getGenres();
}

class MoviesRepo implements MoviesUseCase {
  final NetworkService _networkService;
  List<GenreModel> genres = [];

  MoviesRepo(this._networkService);

  @override
  Future<MovieListModel> getMovies({int page = 1}) async {
    final url =
        "${AppConstants.apiUrl}/movie/popular?language=en-US&page=$page";

    return await _networkService.request(
      url,
      method: HTTPMethod.get,
      fromJson: (data) => MovieListModel.fromJson(data),
    );
  }

  @override
  Future<List<GenreModel>> getGenres() async {
    final url = "${AppConstants.apiUrl}/genre/movie/list?language=en";

    final response = await _networkService.request(
      url,
      method: HTTPMethod.get,
      fromJson: (data) {
        return (data['genres'] as List)
            .map((genre) => GenreModel.fromJson(genre))
            .toList();
      },
    );

    genres = response;

    return response;
  }
}
