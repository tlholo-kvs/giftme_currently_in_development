import 'package:final_application/styles/app_colors.dart';
import 'package:flutter/material.dart';

class YellowStarIcon extends StatelessWidget {
  const YellowStarIcon({
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
