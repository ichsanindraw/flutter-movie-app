import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/view_models/favorite/favorite_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteButton extends ConsumerWidget {
  final MovieModel movieModel;
  const FavoriteButton({
    super.key,
    required this.movieModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMovies =
        ref.watch(favoriteProvider.select((state) => state.favoriteMovies));
    final isFavorite = favoriteMovies.any((movie) => movie.id == movieModel.id);
    return IconButton(
      onPressed: () {
        ref
            .read(favoriteProvider.notifier)
            .addOrRemoveFromFavorites(movieModel);
      },
      icon: Icon(
        isFavorite ? AppIcons.favoriteRounded : AppIcons.favoriteOutlineRounded,
        color: AppColors.redColor,
        size: 20,
      ),
    );
  }
}
