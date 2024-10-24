import 'package:flutter/material.dart';

class UnifyChip extends StatelessWidget {
  final String text;

  const UnifyChip({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
          border: Border.all(color: Theme.of(context).colorScheme.surface),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Text(text),
        ),
      ),
    );
  }
}
