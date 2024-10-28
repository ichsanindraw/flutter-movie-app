import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movie_app/constants/app_theme.dart';
import 'package:flutter_movie_app/screens/splash_screen.dart';
import 'package:flutter_movie_app/service/init_getit.dart';
import 'package:flutter_movie_app/service/navigation_service.dart';
import 'package:flutter_movie_app/view_models/favorite/favorite_bloc.dart';
import 'package:flutter_movie_app/view_models/movie/movie_bloc.dart';
import 'package:flutter_movie_app/view_models/theme/theme_bloc.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    await dotenv.load();

    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => getIt<ThemeBloc>()..add(LoadThemeEvent()),
        ),
        BlocProvider<MovieBloc>(
          create: (context) => getIt<MovieBloc>(),
        ),
        BlocProvider<FavoriteBloc>(
          create: (context) => getIt<FavoriteBloc>()..add(LoadFavorites()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: getIt<NavigationService>().navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Movie App',
            theme: state is DarkThemeState
                ? AppTheme.darkTheme
                : AppTheme.lightTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
