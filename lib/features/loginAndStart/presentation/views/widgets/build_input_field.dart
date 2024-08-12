import 'package:flutter/material.dart';

import '../../manager/cubit/login_and_start_cubit.dart';

class BuildInputField extends StatelessWidget {
  const BuildInputField({
    super.key,
    required this.controller,
    this.isPassword = false,
    required this.valid,
  });
  final TextEditingController? controller;
  final bool isPassword;
  final String? Function(String?) valid;
  @override
  Widget build(BuildContext context) {
    LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);
    Widget icon = (isPassword)
        ? IconButton(
            onPressed: () => loginCubit.changePassVisibility(),
            icon: loginCubit.passIcon,
          )
        : const Icon(Icons.done);
    bool obscureText = (isPassword) ? loginCubit.visibality : false;
    return TextFormField(
      validator: valid,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: icon,
      ),
      obscureText: obscureText,
      // onChanged: (value) {
      //   // print(value);

      //   print(loginCubit.userNameController.text);
      // },
      onFieldSubmitted: (value) {
        (isPassword)
            ? loginCubit.passController.text = value
            : loginCubit.userNameController.text = value;
        print('pass: ${loginCubit.userNameController.text} ');
        print('pass: ${loginCubit.passController.text} ');
      },
    );
  }
}
