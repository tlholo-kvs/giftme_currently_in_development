import 'package:final_application/styles/app_colors.dart';
import 'package:flutter/material.dart';

class BuildRatingIcon extends StatelessWidget {
  const BuildRatingIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star_outline,
      size: 30,
      color: AppColors.yellowIconsColor,
    );
  }
}
