import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/sale_page_cubit.dart';

class DialogOfChargeCard extends StatelessWidget {
  const DialogOfChargeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SalePageCubit saleCubit = SalePageCubit.get(context);
    return AlertDialog(
      title: Column(
        children: [
          const Icon(
            Icons.error_outline,
            size: 40,
            color: AppColors.red,
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<SalePageCubit, SalePageState>(
            builder: (context, state) {
              if (saleCubit.isChoosen &&
                  saleCubit.chargeController.text != '') {
                return Text(
                  // -- Are you sure about the recharge process? --
                  S.of(context).alertChargeDialog1,
                  // -----------------------------------------
                );
              } else {
                return Text(
                  // You did not choose the student or the amount
                  S.of(context).alertChargeDialog2,
                );
              }
            },
          )
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.red,
          ),
          child: Text(
            // ----- cancel ----
            S.of(context).cancel,
            // -----------------
            style: Styles.textStyle18White,
          ),
        ),
        BlocBuilder<SalePageCubit, SalePageState>(
          builder: (context, state) {
            if (saleCubit.isChoosen && saleCubit.chargeController.text != '') {
              return ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  double cash = double.parse(saleCubit.chargeController.text);
                  saleCubit.postStudentCardCharge(
                      {"amount": cash, "student_id": saleCubit.student.id});
                },
                child: Text(
                  S.of(context).charge,
                  style: Styles.textStyle18,
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}
