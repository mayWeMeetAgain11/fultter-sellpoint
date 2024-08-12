import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/custom_Loading_indicator.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/sale_page_cubit.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({
    super.key,
    this.isOffline = false,
  });
  final bool isOffline;
  @override
  Widget build(BuildContext context) {
    SalePageCubit saleCubit = SalePageCubit.get(context);

    return BlocBuilder<SalePageCubit, SalePageState>(
      builder: (context, state) {
        if (state is LoadingSaleFetchStudentState) {
          return const Padding(
            padding: EdgeInsets.all(15),
            child: CustomLoadingIndicator(),
          );
        } else if (state is FailureSaleFetchStudentState) {
          // print(state.errMessage);
          return CustomErrorWidget(
            // ---------- there is an error ---------
            errMessage: state.errMessage,
            // --------------------------------------
          );
        } else
        //  if (state is SuccessSaleFetchStudent ||
        //     state is SalePageInitial)
        {
          if (isOffline) {
            bool isNull = (saleCubit.studentOffline.id == null) ? true : false;
            String name = (isNull)
                //  //'there is no student choosen'
                ? S.of(context).thereIsNoStudentChoosen
                : '${saleCubit.studentOffline.firstName} ${saleCubit.studentOffline.midName} ${saleCubit.studentOffline.lastName}';
            bool isLargerThanDailyAmount =
                (saleCubit.total > saleCubit.studentOffline.totalPrice)
                    ? true
                    : false;
            bool isLargerThanBalance =
                (saleCubit.total > saleCubit.studentOffline.balance)
                    ? true
                    : false;
            return Column(
              children: [
                CustomText(
                  data: name,
                  style: Styles.textStyle13,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        //--- threshold ---
                        data:
                            '${S.of(context).threshold}:  ${saleCubit.studentOffline.threshold}',

                        style: Styles.textStyle13,
                        // ----------------
                      ),
                    ),
                    Expanded(
                      child: CustomText(
                        //--- Total price ---
                        data:
                            '${S.of(context).RestOfTheDailyLimit}:  ${saleCubit.studentOffline.totalPrice}',
                        color: (isLargerThanDailyAmount)
                            ? AppColors.red
                            : const Color.fromARGB(255, 255, 255, 255),
                        style: (isLargerThanDailyAmount)
                            ? Styles.textStyle13White
                            : Styles.textStyle13,
                        // ----------------
                      ),
                    ),
                  ],
                ),
                CustomText(
                  // --- balance ---
                  data:
                      '${S.of(context).balance}: ${saleCubit.studentOffline.balance}',
                  color: (isLargerThanBalance)
                      ? AppColors.red
                      : const Color.fromARGB(255, 255, 255, 255),
                  style: (isLargerThanBalance)
                      ? Styles.textStyle13White
                      : Styles.textStyle13,

                  // ---------------
                ),
              ],
            );
          } else {
            bool isNull = (saleCubit.student.id == null) ? true : false;
            String name = (isNull)
                //  //'there is no student choosen'
                ? S.of(context).thereIsNoStudentChoosen
                : '${saleCubit.student.firstName} ${saleCubit.student.midName} ${saleCubit.student.lastName}';
            bool isLargerThanDailyAmount =
                (saleCubit.total > saleCubit.student.threshold) ? true : false;
            bool isLargerThanBalance =
                (saleCubit.total > saleCubit.student.balance) ? true : false;
            return Column(
              children: [
                CustomText(
                  data: name,
                  style: Styles.textStyle13,
                ),
                CustomText(
                  //--- threshold ---
                  data:
                      '${S.of(context).threshold}:  ${saleCubit.student.threshold}',
                  color: (isLargerThanDailyAmount)
                      ? AppColors.red
                      : const Color.fromARGB(255, 255, 255, 255),
                  style: (isLargerThanDailyAmount)
                      ? Styles.textStyle13White
                      : Styles.textStyle13,
                  // ----------------
                ),
                CustomText(
                  // --- balance ---
                  data:
                      '${S.of(context).balance}: ${saleCubit.student.balance}',
                  color: (isLargerThanBalance)
                      ? AppColors.red
                      : const Color.fromARGB(255, 255, 255, 255),
                  style: (isLargerThanBalance)
                      ? Styles.textStyle13White
                      : Styles.textStyle13,

                  // ---------------
                ),
              ],
            );
          }
        }
        // else {
        //   return const SizedBox();
        // }
      },
    );
  }
}
