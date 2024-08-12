import 'package:flutter/material.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/data_row_of_table_show_another_sp_order.dart';

class TableOfShowAnotherSpOrderPage extends StatelessWidget {
  const TableOfShowAnotherSpOrderPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
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
            color: AppColors.green1,
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return DataRowOfTableShowAnotherSpOrder(
                        index: index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                    itemCount: billCubit.billsOrderFromMe.length,
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
