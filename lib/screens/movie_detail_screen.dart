import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_constants.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/widgets/movies/favorite_button.dart';
import 'package:flutter_movie_app/widgets/movies/genres_widget.dart';
import 'package:flutter_movie_app/widgets/unify_image.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieModel data;

  const MovieDetailScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Hero(
            tag: data.id,
            child: SizedBox(
              width: double.infinity,
              height: size.height * 0.45,
              child: UnifyImage(
                url: "${AppConstants.imageUrl}/${data.posterPath}",
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
                                data.title,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    AppIcons.star,
                                    color: AppColors.yellowColor,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                      "${data.voteAverage.toStringAsFixed(1)}/10"),
                                  const Spacer(),
                                  Text(
                                    data.releaseDate,
                                    style: TextStyle(
                                      color: AppColors.greyColor,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                              GenresWidget(data: data),
                              const SizedBox(height: 16),
                              Text(
                                data.overview,
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
