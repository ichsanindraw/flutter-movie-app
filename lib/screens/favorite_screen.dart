import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/view_models/favorite/favorite_provider.dart';
import 'package:flutter_movie_app/widgets/movies/movie_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteState = ref.watch(favoriteProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(favoriteProvider.notifier).clearAllFavorite();
            },
            icon: Icon(
              AppIcons.delete,
              color: AppColors.redColor,
            ),
          )
        ],
      ),
      body: favoriteState.favoriteMovies.isEmpty
          ? const Center(
              child: Text("No Favorite Movies"),
            )
          : ListView.builder(
              itemCount: favoriteState.favoriteMovies.length,
              itemBuilder: (context, index) {
                return MovieWidget(
                  movieModel: favoriteState.favoriteMovies[index],
                );
              },
            ),
    );
  }
}
