import 'package:flutter/material.dart';
import 'package:flutter_movie_app/widgets/unify_error.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UnifyError(text: "text", onTapped: () {}),
    );
  }
}
