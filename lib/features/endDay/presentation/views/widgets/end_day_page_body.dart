import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/core/widgets/custom_text.dart';
import 'package:selling_point_app/core/widgets/custom_text_form_field.dart';
import 'package:selling_point_app/features/endDay/presentation/manager/cubit/end_day_page_cubit.dart';
import 'package:selling_point_app/features/endDay/presentation/views/widgets/table_of_envelope_end_day_page.dart';
import 'package:selling_point_app/generated/l10n.dart';

import 'envelope_section.dart';

class EndDayPageBody extends StatelessWidget {
  const EndDayPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    EndDayPageCubit endCubit = EndDayPageCubit.get(context);
    return Expanded(
      child: Form(
        key: endCubit.formKay,
        child: Column(
          children: [
            // const EnvelopeSection(),
            // const Divider(),
            CustomText(
              // ---------- Inventory -----------
              data: S.of(context).endDayInventory,
              // --------------------------------
              color: AppColors.green1,
              style: Styles.textStyle18White,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomText(
                      // ---------- Item Name ----------
                      data: S.of(context).endDayItemName,
                      // -------------------------------
                      color: AppColors.green1,
                      style: Styles.textStyle18White,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      // ---------- Quantity -----------
                      data: S.of(context).endDayQuantity,
                      // -------------------------------
                      color: AppColors.green1,
                      style: Styles.textStyle18White,
                    ),
                  ),
                  // Expanded(
                  //   child: CustomText(
                  //     // ---------- Quantity sold -----------
                  //     data: S.of(context).endDaySold,
                  //     // -------------------------------
                  //     color: AppColors.green1,
                  //     style: Styles.textStyle18White,
                  //   ),
                  // ),

                  // Expanded(
                  //   child: CustomText(
                  //     // ---------- Quantity taken-----------
                  //     data: S.of(context).endDaytaken,
                  //     // -------------------------------
                  //     color: AppColors.green1,
                  //     style: Styles.textStyle18White,
                  //   ),
                  // ),
                ],
              ),
            ),
            const TableOfEnvelopeEndDayPage(),
          ],
        ),
      ),
    );
  }
}
