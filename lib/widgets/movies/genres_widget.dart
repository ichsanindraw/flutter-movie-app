import 'package:flutter/material.dart';
import 'package:flutter_movie_app/models/genre/genre_model.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/utils/genre_utils.dart';
import 'package:flutter_movie_app/widgets/unify_chip.dart';

class GenresWidget extends StatelessWidget {
  final MovieModel data;

  const GenresWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    List<GenreModel> genres =
        GenreUtils.movieGenresName(data.genreIds, context);

    return Wrap(
      children: List.generate(
        genres.length,
        (index) => UnifyChip(text: genres[index].name),
      ),
    );
  }
}
