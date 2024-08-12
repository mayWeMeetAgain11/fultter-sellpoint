import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/custom_Loading_indicator.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/core/widgets/custom_error_widget.dart';
import 'package:selling_point_app/core/widgets/custom_left_side.dart';
import 'package:selling_point_app/features/home/presentation/manager/cubit/home_page_cubit.dart';
import 'package:selling_point_app/features/home/presentation/views/widgets/home_selling_app_body.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/manager/cubit/login_and_start_cubit.dart';

import '../../../../constants.dart';
import '../../../../core/cache/cashe_helper.dart';
import '../../../../generated/l10n.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);
    HomePageCubit homeCubit = HomePageCubit.get(context);
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            // ---------------- Home Page ------------------
            CustomLeftSide(
              title: S.of(context).homePageTitle,
              isHome: true,
            ),
            // ----------------------------------------------
            BlocBuilder<HomePageCubit, HomePageState>(
              builder: (context, state) {
                if (state is LoadingfetchActiveCatState) {
                  return const Expanded(
                    child: CustomLoadingIndicator(
                      color: AppColors.green1,
                    ),
                  );
                } else if (state is FailureHomePageState) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomErrorWidget(
                          errMessage: state.errMessage,
                          iconColor: AppColors.green1,
                          textStyle: Styles.textStyle18,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        IconButton(
                          onPressed: () {
                            if (CasheHelper.getData(
                                key: Constants.kfirstTime)) {
                              homeCubit.fetchActiveCategory();
                            } else {
                              // homeCubit.checkForUpdateCAtegory();
                              homeCubit.fetchActiveCategory();
                            }
                          },
                          icon: const Icon(
                            Icons.replay_outlined,
                            color: AppColors.green1,
                          ),
                        ),
                      ],
                    ),
                  );
                } else //if (state is SuccessLoginAndStartState)
                {
                  CasheHelper.setData(key: Constants.kstartDay, value: false);
                  // print(loginCubit.activeCategory.length);
                  return const HomeSellingAppBody();
                }
                // else {
                //   return const SizedBox();
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*
WidgetsFlutterBinding.ensureInitialized();
SestemChrome.setPreferredOrientations([
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,

])
 */
