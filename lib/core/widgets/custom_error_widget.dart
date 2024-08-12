import 'package:flutter/material.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/styles.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.errMessage,
    this.iconColor = AppColors.white,
    this.textStyle = Styles.textStyle18White,
  });
  final String errMessage;
  final Color iconColor;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: iconColor,
        ),
        Text(
          errMessage,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}
