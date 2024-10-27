import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/enums/theme_enums.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/screens/favorite_screen.dart';
import 'package:flutter_movie_app/service/init_getit.dart';
import 'package:flutter_movie_app/service/navigation_service.dart';
import 'package:flutter_movie_app/view_models/movie/movie_provider.dart';
import 'package:flutter_movie_app/view_models/movie/movie_state.dart';
import 'package:flutter_movie_app/view_models/theme_provider.dart';
import 'package:flutter_movie_app/widgets/movies/movie_widget.dart';
import 'package:flutter_movie_app/widgets/unify_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesScreen extends ConsumerWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("REBUILD");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
        actions: [
          IconButton(
            onPressed: () {
              getIt<NavigationService>().navigate(const FavoriteScreen());
            },
            icon: Icon(
              AppIcons.favoriteRounded,
              color: AppColors.redColor,
            ),
          ),
          Consumer(builder: (context, ref, child) {
            log("REBUILD di icon");
            final themeState = ref.watch(themeProvider);
            return IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: Icon(
                themeState == ThemeEnums.light
                    ? AppIcons.darkMode
                    : AppIcons.lightMode,
              ),
            );
          }),
        ],
      ),
      body: Consumer(builder: (context, ref, child) {
        final movieState = ref.watch(movieProvider);

        log("movieState length di movie screen: ${movieState.isLoading}");

        if (movieState.isLoading && movieState.movies.isEmpty) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (movieState.errorMessage.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            getIt<NavigationService>().showSnackbar(movieState.errorMessage);
          });
          return UnifyError(
            text: movieState.errorMessage,
            onTapped: (_) {},
          );
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollNotification) {
              if (scrollNotification.metrics.pixels >=
                      scrollNotification.metrics.maxScrollExtent &&
                  !movieState.isLoading) {
                ref.read(movieProvider.notifier).getMovies();
                return true;
              }

              return false;
            },
            child: ListView.builder(
              itemCount: movieState.movies.length,
              itemBuilder: (context, index) {
                return MovieWidget(movieModel: movieState.movies[index]);
              },
            ),
          );
        }
      }),
    );
  }
}
