import 'package:flutter/material.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/views/widgets/build_form_page.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/views/widgets/right_side_of_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // this line can make keyboard no effect to the screen
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: [
            RightSideOfPage(),
            BuildFormPage(),
          ],
        ),
      ),
    );
  }
}
