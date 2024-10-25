import 'package:flutter/material.dart';
import 'package:flutter_movie_app/screens/movies_screen.dart';
import 'package:flutter_movie_app/service/init_getit.dart';
import 'package:flutter_movie_app/service/navigation_service.dart';
import 'package:flutter_movie_app/view_models/favorites_provider.dart';
import 'package:flutter_movie_app/view_models/movie_provider.dart';
import 'package:flutter_movie_app/widgets/unify_error.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _loadData(BuildContext context) async {
    // await Future.microtask(() async {
    //   if (!context.mounted) return;

    //   await Provider.of<MovieProvider>(context, listen: false).getMovies();
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!context.mounted) return;
      await Provider.of<FavoritesProvider>(context, listen: false)
          .loadFavorites();

      if (!context.mounted) return;
      await Provider.of<MovieProvider>(context, listen: false).getMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _loadData(context),
        builder: (builder, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(),
                  SizedBox(height: 24),
                  Text("Loading..."),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return UnifyError(
              text: snapshot.hasError.toString(),
              onTapped: _loadData,
            );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              getIt<NavigationService>().navigateReplace(const MoviesScreen());
            });
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
