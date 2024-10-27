import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieListModel {
  final int page;
  final List<MovieModel> results;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  @JsonKey(name: 'total_results')
  final int totalResults;

  MovieListModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieListModel.fromJson(Map<String, dynamic> json) {
    return _$MovieListModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MovieListModelToJson(this);
  }
}

@JsonSerializable()
class MovieModel {
  final bool adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

  final int id;

  @JsonKey(name: 'original_language')
  final OriginalLanguage originalLanguage;

  @JsonKey(name: 'original_title')
  final String originalTitle;

  final String overview;
  final double popularity;

  @JsonKey(name: 'poster_path')
  final String posterPath;

  @JsonKey(name: 'release_date')
  final String releaseDate;

  final String title;
  final bool video;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;

  MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return _$MovieModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MovieModelToJson(this);
  }
}

enum OriginalLanguage { en, es, ko, ja, xx, tl, id, sv, th, fr }
