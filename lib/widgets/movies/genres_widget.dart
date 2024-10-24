import 'package:flutter/material.dart';
import 'package:flutter_movie_app/widgets/unify_chip.dart';

class GenresWidget extends StatelessWidget {
  const GenresWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: List.generate(5, (index) => const UnifyChip(text: "Hello")));
  }
}
