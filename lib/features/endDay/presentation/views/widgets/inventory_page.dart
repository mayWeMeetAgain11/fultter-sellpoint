import 'package:flutter/material.dart';
import 'package:selling_point_app/core/widgets/custom_left_side.dart';
import 'package:selling_point_app/features/endDay/presentation/views/widgets/end_day_page_body.dart';
import 'package:selling_point_app/generated/l10n.dart';

import '../../../../bills/presentation/manager/cubit/bill_page_cubit.dart';
import '../../manager/cubit/end_day_page_cubit.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({
    super.key,
    this.typeOfExpenses = 'none',
  });
  final String typeOfExpenses;
  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    EndDayPageCubit endCubit = EndDayPageCubit.get(context);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // Navigator.of(context).pop();
          billCubit.detailsOfSpBill = {};
          endCubit.invintoryController.clear();
          endCubit.dateFOrInventory = DateTime.now();
          billCubit.detailsOfFActoryBill = {};
          return true;
        },
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          body: Row(
            children: [
              CustomLeftSide(
                canReturn: true,
                // ------- EndDay Page ---------
                title: S.of(context).endDayTitle,
                // -----------------------------
                endDay: true,
                typeOfExpenses: typeOfExpenses,
              ),
              const EndDayPageBody(),
            ],
          ),
        ),
      ),
    );
  }
}
