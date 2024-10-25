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
import 'package:provider/provider.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final movieModelProvider = Provider.of<MovieModel>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {
            getIt<NavigationService>().navigate(
              ChangeNotifierProvider<MovieModel>.value(
                value: movieModelProvider,
                child: const MovieDetailScreen(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: movieModelProvider.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: UnifyImage(
                      url:
                          "${AppConstants.imageUrl}/${movieModelProvider.posterPath}",
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieModelProvider.title,
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
                          Text(
                              "${movieModelProvider.voteAverage.toStringAsFixed(1)}/10")
                        ],
                      ),
                      const SizedBox(height: 8),
                      GenresWidget(data: movieModelProvider),
                      Row(
                        children: [
                          Icon(
                            AppIcons.watchLaterOutlined,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            movieModelProvider.releaseDate,
                            style: TextStyle(
                              color: AppColors.greyColor,
                            ),
                          ),
                          const Spacer(),
                          const FavoriteButton()
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
