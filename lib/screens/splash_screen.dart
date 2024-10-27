import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/repository/movies_repo.dart';
import 'package:flutter_movie_app/screens/movies_screen.dart';
import 'package:flutter_movie_app/service/init_getit.dart';
import 'package:flutter_movie_app/service/navigation_service.dart';
import 'package:flutter_movie_app/view_models/movie/movie_bloc.dart';
import 'package:flutter_movie_app/widgets/unify_error.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieBloc = getIt<MovieBloc>();

    return Scaffold(
      body: BlocListener<MovieBloc, MovieState>(
        listener: (context, state) {
          if (state is MovieSuccess) {
            getIt<NavigationService>().navigateReplace(const MoviesScreen());
          }
        },
        child: BlocBuilder<MovieBloc, MovieState>(
          bloc: movieBloc..add(GetMoviesEvent()),
          builder: (context, state) {
            if (state is MovieLoading) {
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
            }

            if (state is MovieError) {
              return UnifyError(
                text: state.message,
                onTapped: () {
                  movieBloc.add(GetMoviesEvent());
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   bool _isLoading = true;
//   String _errorMessage = "";
//   final _movieRepository = getIt<MoviesRepo>();

//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }

//   Future<void> _loadData() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = "";
//     });

//     try {
//       await _movieRepository.getGenres();
//       await getIt<NavigationService>().navigateReplace(const MoviesScreen());
//     } catch (e) {
//       setState(() {
//         _errorMessage = e.toString();
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _isLoading
          // ? const Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         CircularProgressIndicator.adaptive(),
          //         SizedBox(height: 24),
          //         Text("Loading..."),
          //       ],
          //     ),
          //   )
          // : UnifyError(
          //     text: _errorMessage,
          //     onTapped: _loadData,
          //   ),
//     );
//   }
// }
