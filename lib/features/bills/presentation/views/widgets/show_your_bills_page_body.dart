import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/core/widgets/custom_text.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/table_of_show_your_bills_page_body.dart';
import 'package:selling_point_app/generated/l10n.dart';

import '../../manager/cubit/bill_page_cubit.dart';

class ShowYourBillsPageBody extends StatelessWidget {
  const ShowYourBillsPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BillPageCubit ourCubit = BillPageCubit.get(context);
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              // --------- id ---------
              Expanded(
                child: CustomText(
                  // -------------- ID --------------
                  data: S.of(context).showYourBillsId,
                  // --------------------------------
                  color: AppColors.green1,
                  style: Styles.textStyle18White,
                ),
              ),
              // --------- sp name of null --------
              BlocBuilder<BillPageCubit, BillPageState>(
                builder: (context, state) {
                  if (state is SuccessToSpBillState) {
                    return Expanded(
                      child: CustomText(
                        // -------------- SP Name --------------
                        data: S.of(context).spNameInshowyourBill,
                        // ----------------------------------
                        color: AppColors.green1,
                        style: Styles.textStyle18White,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              //- ---- - date ----------
              Expanded(
                child: CustomText(
                  // -------------- Date --------------
                  data: S.of(context).showYourBillsDate,
                  // ----------------------------------
                  color: AppColors.green1,
                  style: Styles.textStyle18White,
                ),
              ),
              // -------- botton
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ourCubit.changeToFactoryBill();
                      },
                      child: Text(
                        // ------------- from factory --------------
                        S.of(context).showYourBillsBottomFromFactory,
                        // -----------------------------------------
                        style: Styles.textStyle15Green1,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ourCubit.changeToSpBill();
                      },
                      child: Text(
                        // -------------- from SP -------------
                        S.of(context).showYourBillsBottomFromSp,
                        // ------------------------------------
                        style: Styles.textStyle15Green1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const TableOfShowYourBillsPageBody(),
        ],
      ),
    );
  }
}
