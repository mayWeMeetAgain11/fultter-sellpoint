import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/widgets/custom_text.dart';

class MobileBody extends StatelessWidget {
  const MobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.green1,
      body: Center(
        child: CustomText(data: 'your divice not supported this app'),
      ),
    );
  }
}
