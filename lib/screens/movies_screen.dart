import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/screens/favorite_screen.dart';
import 'package:flutter_movie_app/service/init_getit.dart';
import 'package:flutter_movie_app/service/navigation_service.dart';
import 'package:flutter_movie_app/view_models/movie/movie_bloc.dart';
import 'package:flutter_movie_app/view_models/theme/theme_bloc.dart';
import 'package:flutter_movie_app/widgets/movies/movie_widget.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  getIt<ThemeBloc>().add(ToggleThemeEvent());
                },
                icon: Icon(
                  state is DarkThemeState
                      ? AppIcons.lightMode
                      : AppIcons.darkMode,
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is MovieError) {
            return Center(child: Text(state.message));
          } else {
            if (state is MovieSuccess) {
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    getIt<MovieBloc>().add(LoadMoreEvent());
                    return true;
                  }

                  return false;
                },
                child: ListView.builder(
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    return MovieWidget(data: state.movies[index]);
                    // if (index < _movies.length) {
                    //   return Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: MovieWidget(data: _movies[index]),
                    //   );
                    // } else {
                    //   return const CircularProgressIndicator.adaptive();
                    // }
                  },
                ),
              );
            } else {
              return const Center(child: Text("No Data"));
            }
          }
        },
      ),
    );
  }
}
