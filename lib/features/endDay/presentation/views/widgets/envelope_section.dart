import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/end_day_page_cubit.dart';

class EnvelopeSection extends StatelessWidget {
  const EnvelopeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    EndDayPageCubit endCubit = EndDayPageCubit.get(context);
    return Form(
      key: endCubit.formKay,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  CustomText(
                    // -- address of the envelope ---
                    data: S.of(context).endDayAddress,
                    // ------------------------------
                    color: AppColors.green1,
                    style: Styles.textStyle18White,
                  ),
                  CustomTextFormField(
                    controller: endCubit.envelopeAddress,
                    // --------- enter the address -----------
                    hintText: S.of(context).endDayAddressField,
                    // ---------------------------------------
                    validator: (x) {
                      if (x!.isEmpty) {
                        // --------- Please enter data -----------
                        return S.of(context).loginValidateMessage;
                        // ---------------------------------------
                      }
                      return null;
                    },
                    onTap: (x) {},
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                      // FilteringTextInputFormatter.allow(
                      // RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  CustomText(
                    // - amount inside the envelope -
                    data: S.of(context).endDayAmount,
                    // ------------------------------
                    color: AppColors.green1,
                    style: Styles.textStyle18White,
                  ),
                  CustomTextFormField(
                    controller: endCubit.envelopeAmount,
                    // --------- enter the amount -----------
                    hintText: S.of(context).endDayAmountField,
                    // --------------------------------------
                    validator: (x) {
                      if (x!.isEmpty) {
                        // --------- Please enter data -----------
                        return S.of(context).loginValidateMessage;
                        // ---------------------------------------
                      }
                      return null;
                    },
                    onTap: (x) {},
                    inputFormatters: [
                      // FilteringTextInputFormatter.digitsOnly
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                  ),
                ],
              )
              // Column(
              //   children: [
              //     CustomText(
              //       // ------ amountTaken -----------
              //       data: S.of(context).amountTaken,
              //       // ------------------------------
              //       color: AppColors.green1,
              //       style: Styles.textStyle18White,
              //     ),
              //     CustomTextFormField(
              //       controller: endCubit.takenAmount,
              //       // --------- enter the amount -----------
              //       hintText: S.of(context).endDayAmountField,
              //       // --------------------------------------
              //       validator: (x) {
              //         if (x!.isEmpty) {
              //           // --------- Please enter data -----------
              //           return S.of(context).loginValidateMessage;
              //           // ---------------------------------------
              //         }
              //         return null;
              //       },
              //       onTap: (x) {},
              //       inputFormatters: [
              //         // FilteringTextInputFormatter.digitsOnly
              //         FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              //       ],
              //     ),
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }
}
