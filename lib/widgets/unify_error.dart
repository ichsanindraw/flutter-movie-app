import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';

class UnifyError extends StatelessWidget {
  final String text;
  final Function onTapped;

  const UnifyError({
    super.key,
    required this.text,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            AppIcons.error,
            size: 50,
            color: AppColors.redColor,
          ),
          const SizedBox(height: 24),
          Text(
            "Error $text",
            style: TextStyle(
              color: AppColors.redColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              onTapped();
            },
            child: Text(
              "Retry",
              style: TextStyle(
                color: AppColors.whiteColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
