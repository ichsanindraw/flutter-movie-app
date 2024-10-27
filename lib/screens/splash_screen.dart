import 'package:flutter/material.dart';
import 'package:flutter_movie_app/screens/movies_screen.dart';
import 'package:flutter_movie_app/service/init_getit.dart';
import 'package:flutter_movie_app/service/navigation_service.dart';
import 'package:flutter_movie_app/view_models/favorite/favorite_provider.dart';
import 'package:flutter_movie_app/view_models/movie/movie_provider.dart';
import 'package:flutter_movie_app/widgets/unify_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initializationProvider = FutureProvider.autoDispose<void>((ref) async {
  ref.keepAlive();
  await Future.microtask(() async {
    await ref.read(favoriteProvider.notifier).loadFavorites();
    await ref.read(movieProvider.notifier).getMovies();
  });
});

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initWatch = ref.watch(initializationProvider);

    return Scaffold(
      body: initWatch.when(
        data: (_) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            getIt<NavigationService>().navigateReplace(const MoviesScreen());
          });
          return const SizedBox.shrink();
        },
        error: (error, _) {
          return UnifyError(
            text: error.toString(),
            onTapped: () => ref.refresh(initializationProvider),
          );
        },
        loading: () {
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
        },
      ),
    );
  }
}
