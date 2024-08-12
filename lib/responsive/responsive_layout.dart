import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:selling_point_app/core/widgets/custom_text.dart';

class ResponiveLayout extends StatelessWidget {
  const ResponiveLayout(
      {super.key, required this.mobileBody, required this.tapBody});
  final Widget mobileBody;
  final Widget tapBody;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // return CustomText(data: constraints.maxWidth.toString());
        if (constraints.maxWidth < 1000) {
          return mobileBody;
        } else {
          return tapBody;
        }
      },
    );
  }
}
