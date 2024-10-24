import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';
import 'package:flutter_movie_app/models/movie/movie_model.dart';
import 'package:flutter_movie_app/repository/movies_repo.dart';
import 'package:flutter_movie_app/screens/favorite_screen.dart';
import 'package:flutter_movie_app/service/init_getit.dart';
import 'package:flutter_movie_app/service/navigation_service.dart';
import 'package:flutter_movie_app/widgets/movies/movie_widget.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final ScrollController _scrollController = ScrollController();

  List<MovieModel> _movies = [];
  int currentPage = 1;
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();

    _fetchMovies();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_isFetching) {
      _fetchMovies();
    }
  }

  Future<void> _fetchMovies() async {
    if (_isFetching) return;

    setState(() {
      _isFetching = true;
    });

    try {
      final movies = await getIt<MoviesRepo>().getMovies(page: currentPage);

      setState(() {
        _movies.addAll(movies.results);
        currentPage++;
      });
    } catch (e) {
      print(e.toString());
      getIt<NavigationService>().showSnackbar(e.toString());
    } finally {
      setState(() {
        _isFetching = false;
      });
    }
  }

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
          IconButton(
            onPressed: () {},
            icon: Icon(AppIcons.darkMode),
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _movies.length + (_isFetching ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _movies.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: MovieWidget(data: _movies[index]),
            );
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        },
      ),
    );
  }
}
