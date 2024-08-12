import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/core/widgets/custom_text_form_field.dart';
import 'package:selling_point_app/features/endDay/presentation/manager/cubit/end_day_page_cubit.dart';
import 'package:selling_point_app/features/home/presentation/manager/cubit/home_page_cubit.dart';
import 'package:selling_point_app/generated/l10n.dart';

import '../../../../../constants.dart';
import '../../../../../core/cache/cashe_helper.dart';

class DataRowOfTableOfEnvelopeEndDayPage extends StatelessWidget {
  const DataRowOfTableOfEnvelopeEndDayPage({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    HomePageCubit homeCubit = HomePageCubit.get(context);
    EndDayPageCubit endCubit = EndDayPageCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Material(
        color: const Color.fromARGB(255, 255, 255, 255),
        shadowColor: const Color.fromARGB(89, 197, 191, 191),
        elevation: 10,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Container(
          // height: 100,
          padding: const EdgeInsets.all(10),
          child: IntrinsicHeight(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          (index + 1).toString(),
                          style: Styles.textStyle18,
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: Text(
                          (CasheHelper.getData(key: Constants.klangSympol) ==
                                  'en')
                              ? homeCubit.activeCategory[index].nameEn!
                              : homeCubit.activeCategory[index].nameAr!,
                          // textAlign: TextAlign.center,
                          style: Styles.textStyle18,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomTextFormField(
                    autoFocus: false,
                    controller: endCubit.invintoryController[index],
                    // -------- enter the Remaining quantity -------
                    hintText: S.of(context).endDayHintText,
                    // ---------------------------------------
                    onTap: (x) {},
                    validator: (x) {
                      if (x!.isEmpty) {
                        // --------- Please enter data -----------
                        return S.of(context).loginValidateMessage;
                        // ---------------------------------------
                      }
                      return null;
                    },
                    inputFormatters: [
                      // FilteringTextInputFormatter.allow(
                      //   RegExp(r'^\d+\.?\d{0,2}'),
                      // ),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),

                // SizedBox(
                //   width: 10,
                // ),
                // Expanded(
                //   child: CustomTextFormField(
                //     controller: endCubit.soldController[index],
                //     // -------- enter the sold quantity -------
                //     hintText: S.of(context).endDaySoldHintText,
                //     // -----------------------------------w
                //     onTap: (x) {},
                //     validator: (x) {
                //       if (x!.isEmpty) {
                //         // --------- Please enter data -----------
                //         return S.of(context).loginValidateMessage;
                //         // ---------------------------------------
                //       }
                //       return null;
                //     },
                //     inputFormatters: [
                //       FilteringTextInputFormatter.digitsOnly
                //       // FilteringTextInputFormatter.allow(
                //       //   RegExp(r'^\d+\.?\d{0,2}'),
                //       // ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   width: 10,
                // ),
                // Expanded(
                //   child: CustomTextFormField(
                //     controller: endCubit.takenController[index],
                //     // -------- enter the taken quantity -------
                //     hintText: S.of(context).endDaytakenHintText,
                //     // -----------------------------------w
                //     onTap: (x) {},
                //     validator: (x) {
                //       if (x!.isEmpty) {
                //         // --------- Please enter data -----------
                //         return S.of(context).loginValidateMessage;
                //         // ---------------------------------------
                //       }
                //       return null;
                //     },
                //     inputFormatters: [
                //       FilteringTextInputFormatter.digitsOnly
                //       // FilteringTextInputFormatter.allow(
                //       //   RegExp(r'^\d+\.?\d{0,2}'),
                //       // ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
