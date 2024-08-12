import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/custom_Loading_indicator.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/core/widgets/custom_error_widget.dart';
import 'package:selling_point_app/core/widgets/custom_text.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/table_of_show_another_sp_order_page.dart';
import 'package:selling_point_app/generated/l10n.dart';

class ShowAnotherSpOrderPageBody extends StatelessWidget {
  const ShowAnotherSpOrderPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomText(
                  // ------------- ID ---------------
                  data: S.of(context).showYourBillsId,
                  // --------------------------------
                  color: AppColors.green1,
                  style: Styles.textStyle18White,
                ),
              ),
              Expanded(
                child: CustomText(
                  // ------------- Date ---------------
                  data: S.of(context).showYourBillsDate,
                  // ----------------------------------
                  color: AppColors.green1,
                  style: Styles.textStyle18White,
                ),
              ),
              Expanded(
                child: CustomText(
                  // --------------- from sp -----------------
                  data: S.of(context).showAnotherSpOrderFromSp,
                  // -----------------------------------------
                  color: AppColors.green1,
                  style: Styles.textStyle18White,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
          BlocBuilder<BillPageCubit, BillPageState>(
            builder: (context, state) {
              if (state is LoadingBillState) {
                return const Expanded(
                  child: CustomLoadingIndicator(
                    color: AppColors.green1,
                  ),
                );
              } else if (state is FailureBillState) {
                return Expanded(
                  child: CustomErrorWidget(
                    errMessage: state.errMessage,
                  ),
                );
              } else {
                return const TableOfShowAnotherSpOrderPage();
              }
            },
          ),
        ],
      ),
    );
  }
}
