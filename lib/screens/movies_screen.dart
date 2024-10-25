import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/constants/app_theme.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/screens/favorite_screen.dart';
import 'package:flutter_movie_app/service/init_getit.dart';
import 'package:flutter_movie_app/service/navigation_service.dart';
import 'package:flutter_movie_app/view_models/movie_provider.dart';
import 'package:flutter_movie_app/view_models/theme_provider.dart';
import 'package:flutter_movie_app/widgets/movies/movie_widget.dart';
import 'package:flutter_movie_app/widgets/unify_error.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("REBUILD");

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
          Consumer(builder: (context, ThemeProvider themeProvider, child) {
            return IconButton(
              onPressed: () {
                themeProvider.toggleTheme();
              },
              icon: Icon(
                themeProvider.themeData == AppTheme.darkTheme
                    ? AppIcons.lightMode
                    : AppIcons.darkMode,
              ),
            );
          }),
        ],
      ),
      body: Consumer(builder: (context, MovieProvider movieProvider, child) {
        if (movieProvider.isLoading && movieProvider.movies.isEmpty) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (movieProvider.errorGetMovies.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            getIt<NavigationService>().showSnackbar(e.toString());
          });
          return UnifyError(
            text: movieProvider.errorGetMovies,
            onTapped: (_) {},
          );
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollNotification) {
              if (scrollNotification.metrics.pixels >=
                      scrollNotification.metrics.maxScrollExtent &&
                  !movieProvider.isLoading) {
                movieProvider.getMovies();
                return true;
              }

              return false;
            },
            child: ListView.builder(
              itemCount: movieProvider.movies.length,
              itemBuilder: (context, index) {
                if (index < movieProvider.movies.length) {
                  return ChangeNotifierProvider<MovieModel>.value(
                    value: movieProvider.movies[index],
                    child: const MovieWidget(),
                  );
                } else {
                  return const CircularProgressIndicator.adaptive();
                }
              },
            ),
          );
        }
      }),
    );
  }
}

// class MoviesScreen extends StatelessWidget {
//   const MoviesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Popular Movies"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               getIt<NavigationService>().navigate(const FavoriteScreen());
//             },
//             icon: Icon(
//               AppIcons.favoriteRounded,
//               color: AppColors.redColor,
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               themeProvider.toggleTheme();
//             },
//             icon: Icon(AppIcons.darkMode),
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Text("hehe");
//           // if (index < _movies.length) {
//           // return Padding(
//           //   padding: const EdgeInsets.all(8.0),
//           //   child: MovieWidget(data: _movies[index]),
//           // );
//           // } else {
//           //   return const CircularProgressIndicator.adaptive();
//           // }
//         },
//       ),
//     );
//   }
// }
