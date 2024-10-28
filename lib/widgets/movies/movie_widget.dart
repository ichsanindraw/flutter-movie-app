import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_constants.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/screens/movie_detail_screen.dart';
import 'package:flutter_movie_app/service/init_getit.dart';
import 'package:flutter_movie_app/service/navigation_service.dart';
import 'package:flutter_movie_app/widgets/movies/favorite_button.dart';
import 'package:flutter_movie_app/widgets/movies/genres_widget.dart';
import 'package:flutter_movie_app/widgets/unify_image.dart';

class MovieWidget extends StatelessWidget {
  final MovieModel data;

  const MovieWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {
            getIt<NavigationService>().navigate(MovieDetailScreen(data: data));
          },
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: data.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: UnifyImage(
                      url: "${AppConstants.imageUrl}/${data.posterPath}",
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            AppIcons.star,
                            color: AppColors.yellowColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text("${data.voteAverage.toStringAsFixed(1)}/10")
                        ],
                      ),
                      const SizedBox(height: 8),
                      GenresWidget(data: data),
                      Row(
                        children: [
                          Icon(
                            AppIcons.watchLaterOutlined,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            data.releaseDate,
                            style: TextStyle(
                              color: AppColors.greyColor,
                            ),
                          ),
                          const Spacer(),
                          FavoriteButton(movieModel: data)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
