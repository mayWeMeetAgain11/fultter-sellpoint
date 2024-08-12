import 'package:flutter/material.dart';

import '../../../../../core/utils/app_color.dart';

class RightSideOfPage extends StatelessWidget {
  const RightSideOfPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(30),
            bottomEnd: Radius.circular(30),
          ),
          color: AppColors.green1,
          // image: DecorationImage(
          //   image: AssetImage('assets/image/bg.png'),
          //   fit: BoxFit.cover,
          //   colorFilter: ColorFilter.mode(
          //     AppColors.green1.withOpacity(0.2),
          //     BlendMode.dstATop,
          //   ),
          // ),
        ),
      ),
    );
  }
}
