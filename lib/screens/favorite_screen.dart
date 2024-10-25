import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/view_models/favorites_provider.dart';
import 'package:flutter_movie_app/widgets/movies/movie_widget.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies"),
        actions: [
          Consumer(
            builder: (context, FavoritesProvider favoriteProvider, child) {
              return IconButton(
                onPressed: () {
                  favoriteProvider.clearAllFavorite();
                },
                icon: Icon(
                  AppIcons.delete,
                  color: AppColors.redColor,
                ),
              );
            },
          )
        ],
      ),
      body: Consumer(
        builder: (context, FavoritesProvider favoriteProvider, child) {
          if (favoriteProvider.favoritesMovies.isEmpty) {
            return const Center(
              child: Text("There is no favorite movie"),
            );
          }

          return ListView.builder(
            itemCount: favoriteProvider.favoritesMovies.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider<MovieModel>.value(
                value: favoriteProvider.favoritesMovies[index],
                child: const MovieWidget(),
              );
            },
          );
        },
      ),
    );
  }
}
