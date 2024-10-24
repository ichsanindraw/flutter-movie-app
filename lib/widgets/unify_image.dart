import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';
import 'package:flutter_movie_app/constants/app_icons.dart';

class UnifyImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  const UnifyImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return CachedNetworkImage(
      width: width ?? size.width * 0.2,
      height: height ?? size.width * 0.3,
      imageUrl: url,
      fit: boxFit ?? BoxFit.cover,
      errorWidget: (context, url, error) => Icon(
        AppIcons.error,
        color: AppColors.redColor,
      ),
    );
  }
}
