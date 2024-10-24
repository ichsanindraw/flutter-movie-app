import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_theme.dart';
import 'package:flutter_movie_app/screens/movie_detail_screen.dart';
import 'package:flutter_movie_app/screens/movies_screen.dart';
import 'package:flutter_movie_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: AppTheme.lightTheme,
      // home: const MoviesScreen(),
      // home: const MovieDetailScreen(),
      home: const SplashScreen(),
    );
  }
}
