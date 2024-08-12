import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/views/splash_view.dart';
import 'package:selling_point_app/responsive/responsive_layout.dart';

import 'mobile_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponiveLayout(
      mobileBody: MobileBody(),
      tapBody: SplashView(),
    );
  }
}
