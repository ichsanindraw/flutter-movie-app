import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/service/init_getit.dart';
import 'package:flutter_movie_app/view_models/favorite/favorite_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final MovieModel movieModel;

  const FavoriteButton({
    super.key,
    required this.movieModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        bool isFavorite = getIt<FavoriteBloc>().isFavorite(movieModel);

        return IconButton(
          onPressed: () {
            getIt<FavoriteBloc>().add(
              isFavorite
                  ? RemoveFromFavorites(movieModel)
                  : AddToFavorites(movieModel),
            );
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
