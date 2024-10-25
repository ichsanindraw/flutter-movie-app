import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_constants.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/widgets/movies/favorite_button.dart';
import 'package:flutter_movie_app/widgets/movies/genres_widget.dart';
import 'package:flutter_movie_app/widgets/unify_image.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieModelProvider = Provider.of<MovieModel>(context);
    // final size = MediaQuery.of(context).size;
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Hero(
            tag: movieModelProvider.id,
            child: SizedBox(
              width: double.infinity,
              height: size.height * 0.45,
              child: UnifyImage(
                url:
                    "${AppConstants.imageUrl}/${movieModelProvider.posterPath}",
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.4,
                  // child: Container(color: AppColors.redColor),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 24),
                              Text(
                                movieModelProvider.title,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    AppIcons.star,
                                    color: AppColors.yellowColor,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                      "${movieModelProvider.voteAverage.toStringAsFixed(1)}/10"),
                                  const Spacer(),
                                  Text(
                                    movieModelProvider.releaseDate,
                                    style: TextStyle(
                                      color: AppColors.greyColor,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                              GenresWidget(data: movieModelProvider),
                              const SizedBox(height: 16),
                              Text(
                                movieModelProvider.overview,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: FavoriteButton(),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const BackButton(),
            ),
          ),
        ],
      )),
    );
  }
}
