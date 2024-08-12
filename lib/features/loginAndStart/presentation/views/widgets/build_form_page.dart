import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import '../../../../../core/cache/cashe_helper.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/custom_Loading_indicator.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/login_and_start_cubit.dart';
import '../start_page.dart';
import 'build_input_field.dart';
import 'build_login_button.dart';

class BuildFormPage extends StatelessWidget {
  const BuildFormPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKay = GlobalKey<FormState>();
    LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(70),
        child: SingleChildScrollView(
          child: Form(
            key: formKay,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // ------ wellcome -----
                  S.of(context).loginTitle,
                  // ---------------------
                  style: const TextStyle(
                    color: AppColors.green1,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    fontFamily: Constants.kCairoFont,
                  ),
                ),
                Text(
                  // -- Please login with your information --
                  S.of(context).loginSubTitle,
                  // ----------------------------------------
                  style: const TextStyle(
                    color: Colors.grey,
                    fontFamily: Constants.kCairoFont,
                  ),
                ),
                const SizedBox(height: 60),
                Text(
                  // ------ User Name -------
                  S.of(context).loginUserName,
                  // ------------------------
                  style: const TextStyle(
                    color: Colors.grey,
                    fontFamily: Constants.kCairoFont,
                  ),
                ),
                BuildInputField(
                  controller: loginCubit.userNameController,
                  valid: (p0) {
                    if (p0!.isEmpty) {
                      // ---- Please enter data ---------------
                      return S.of(context).loginValidateMessage;
                      // --------------------------------------
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                Text(
                  // ------- Password -------
                  S.of(context).loginPassword,
                  // -------------------------
                  style: const TextStyle(
                    color: Colors.grey,
                    fontFamily: Constants.kCairoFont,
                  ),
                ),
                BlocBuilder<LoginAndStartCubit, LoginAndStartState>(
                  builder: (context, state) {
                    return BuildInputField(
                      controller: loginCubit.passController,
                      isPassword: true,
                      valid: (p0) {
                        if (p0!.isEmpty) {
                          // --------- Please enter data ----------
                          return S.of(context).loginValidateMessage;
                          // --------------------------------------
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // const BuildRememberForgot(),
                const SizedBox(
                  height: 20,
                ),
                BuildLoginButton(
                  formKay: formKay,
                  // userName: loginCubit.userNameController.text,
                  // password: loginCubit.passController.text,
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocConsumer<LoginAndStartCubit, LoginAndStartState>(
                  listener: (context, state) {
                    if (state is SuccessSignUpState) {
                      CasheHelper.setData(
                        key: Constants.ktoken,
                        value: state.sellPointInfo.token,
                      );
                      CasheHelper.setData(
                          key: Constants.kID,
                          value: state.sellPointInfo.data!.id);
                      CasheHelper.setData(
                          key: Constants.kNameSp,
                          value: state.sellPointInfo.data!.name);
                      loginCubit.passController.clear();
                      loginCubit.userNameController.clear();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const StartPage(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingLoginAndStartState) {
                      return const CustomLoadingIndicator(
                        color: AppColors.green1,
                      );
                    } else if (state is FailureLoginAndStartState) {
                      return CustomErrorWidget(
                        errMessage: state.errMessage,
                        iconColor: AppColors.green1,
                        textStyle: Styles.textStyle15DarkGreen,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
