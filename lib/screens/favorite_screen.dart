import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_constants.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/service/init_getit.dart';
import 'package:flutter_movie_app/view_models/favorite/favorite_bloc.dart';
import 'package:flutter_movie_app/widgets/movies/movie_widget.dart';
import 'package:flutter_movie_app/widgets/unify_error.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies"),
        actions: [
          IconButton(
            onPressed: () {
              getIt<FavoriteBloc>().add(RemoveAllFavorites());
            },
            icon: Icon(
              AppIcons.delete,
              color: AppColors.redColor,
            ),
          )
        ],
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is FavoriteError) {
            return UnifyError(
              text: state.message,
              onTapped: () {
                getIt<FavoriteBloc>().add(LoadFavorites());
              },
            );
          } else if (state is FavoriteLoaded) {
            if (state.favorites.isEmpty) {
              return const Center(child: Text("No Favorites Data"));
            }

            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                return MovieWidget(data: state.favorites[index]);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
