import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_constants.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/widgets/movies/movie_widget.dart';
import 'package:flutter_movie_app/widgets/unify_image.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              AppIcons.favoriteRounded,
              color: AppColors.redColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(AppIcons.darkMode),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: MovieWidget(imageUrl: AppConstants.imagePlaceholder),
          );
        },
      ),
    );
  }
}
