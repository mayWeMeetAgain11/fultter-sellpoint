import 'dart:async';

import 'package:flutter/material.dart';
import 'package:selling_point_app/constants.dart';
import 'package:selling_point_app/core/cache/cashe_helper.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/custom_Loading_indicator.dart';
import 'package:selling_point_app/features/home/presentation/views/home_app_page.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/manager/cubit/login_and_start_cubit.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/views/login_page.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/views/start_page.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);

    super.initState();
    String? token = CasheHelper.getData(key: Constants.ktoken);

    /* 
    startDay variable can't be Null because it initialed 
    in casheInit methods before run the app in main function
    */
    bool startDay = CasheHelper.getData(key: Constants.kstartDay);
    Timer(
      const Duration(seconds: 3),
      () {
        if (token != null) {
          loginCubit.sellPointInfo.data!.id =
              CasheHelper.getData(key: Constants.kID);
          loginCubit.sellPointInfo.data!.name =
              CasheHelper.getData(key: Constants.kNameSp);
          // loginCubit.sellPointInfo.token =
          //     CasheHelper.getData(key: Constants.ktoken);
          if (startDay) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const StartPage(),
              ),
            );
          } 
          else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ),
            );
          }
        } else {
          CasheHelper.setData(key: Constants.kfirstTime, value: true);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green1,
      body: Center(
        child: Container(
          height: 200,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
          ),
          child: const CustomLoadingIndicator(color: AppColors.green1),
        ),
      ),
    );
  }
}
