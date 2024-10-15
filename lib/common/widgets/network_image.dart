import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:testapp/common/gen/assets.gen.dart';


class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    this.height = 120.0,
    this.width = 120.0,
    required this.imagePath,
    this.borderRadius = 16,
  });

  final double height;
  final double width;
  final double borderRadius;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CachedNetworkImage(
        imageUrl: imagePath,
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Assets.icons.logo.image(),
      ),
    );
  }
}
