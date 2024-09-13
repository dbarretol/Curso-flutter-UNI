import 'package:flutter/material.dart';
import 'package:myapp/utils/app_colors.dart';
import 'package:myapp/utils/dimensions.dart';

class HeadingImage extends StatelessWidget {
  final String imagePath;
  final String title;

  const HeadingImage({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: 170,
            width: double.infinity,
            child: Image.asset(imagePath, fit: BoxFit.cover)),
        Positioned(
            bottom: Dimensions.mediumPadding,
            right: Dimensions.mediumPadding,
            child: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: AppColors.onPrimary)))
      ],
    );
  }
}
