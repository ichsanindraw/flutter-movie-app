import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/widgets/movies/favorite_button.dart';
import 'package:flutter_movie_app/widgets/movies/genres_widget.dart';
import 'package:flutter_movie_app/widgets/unify_image.dart';

class MovieWidget extends StatelessWidget {
  final String imageUrl;

  const MovieWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {
            // TODO: Navigate to movie detail
          },
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: UnifyImage(
                    url: imageUrl,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Movie Title",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                          const Text("8/10")
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            AppIcons.watchLaterOutlined,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Release Date",
                            style: TextStyle(
                              color: AppColors.greyColor,
                            ),
                          ),
                          const Spacer(),
                          const FavoriteButton()
                        ],
                      ),
                      const GenresWidget()
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
