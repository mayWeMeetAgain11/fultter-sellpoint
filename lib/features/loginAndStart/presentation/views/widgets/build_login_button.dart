import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../../../../../core/cache/cashe_helper.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/login_and_start_cubit.dart';

class BuildLoginButton extends StatelessWidget {
  const BuildLoginButton({
    super.key,
    required this.formKay,
    // required this.userName,
    // required this.password,
  });
  final GlobalKey<FormState> formKay;
  // final String userName;
  // final String password;

  @override
  Widget build(BuildContext context) {
    LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);
    return ElevatedButton(
      onPressed: () async {
        if (formKay.currentState!.validate()) {
          var data = {
            "user": loginCubit.userNameController.text,
            "password": loginCubit.passController.text,
          };
          await CasheHelper.setData(key: Constants.kstartDay, value: true);
          print(CasheHelper.getData(key: Constants.kstartDay).toString());
          print('userName:  ${loginCubit.userNameController.text}');
          print('password:  ${loginCubit.passController.text}');

          loginCubit.loginAccounting(data);
        }
      },
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 10,
          shadowColor: AppColors.green1,
          minimumSize: const Size.fromHeight(60)),
      child: Text(
        // ------- LOGIN -----
        S.of(context).loginLogin,
        // ---------------------
        style: const TextStyle(
          letterSpacing: 2,
          fontFamily: Constants.kCairoFont,
        ),
      ),
    );
  }
}
