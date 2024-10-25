import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/view_models/favorites_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final movieModelProvider = Provider.of<MovieModel>(context);

    return Consumer(
      builder: (context, FavoritesProvider favoritesProvider, child) {
        final bool isFavorite =
            favoritesProvider.isFavorite(movieModelProvider);

        return IconButton(
          onPressed: () {
            favoritesProvider.addOrRemoveFromFavorites(movieModelProvider);
          },
          icon: Icon(
            isFavorite
                ? AppIcons.favoriteRounded
                : AppIcons.favoriteOutlineRounded,
            color: isFavorite ? AppColors.redColor : null,
            size: 20,
          ),
        );
      },
    );
  }
}
