import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/custom_Loading_indicator.dart';
import 'package:selling_point_app/core/widgets/custom_error_widget.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/data_row_of_table_of_show_your_bills.dart';

class TableOfShowYourBillsPageBody extends StatelessWidget {
  const TableOfShowYourBillsPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            // bottomLeft: Radius.circular(20),
            // bottomRight: Radius.circular(20),
          ),
          child: Container(
            width: double.infinity,
            color: AppColors.green1,
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<BillPageCubit, BillPageState>(
                    builder: (context, state) {
                      if (state is LoadingBillState) {
                        return const CustomLoadingIndicator();
                      } else if (state is FailureBillState) {
                        return CustomErrorWidget(errMessage: state.errMessage);
                      } else if (state is SuccessToFactoryBillState) {
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            return DataRowOfTableOfShowYourBills(
                              index: index,
                              bills: state.billsToFActory,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox();
                          },
                          itemCount: state.billsToFActory.length,
                        );
                      } else if (state is SuccessToSpBillState) {
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            return DataRowOfTableOfShowYourBills(
                              index: index,
                              bills: state.billsToSp,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox();
                          },
                          itemCount: state.billsToSp.length,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
