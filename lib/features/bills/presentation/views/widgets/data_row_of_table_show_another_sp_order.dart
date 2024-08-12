import 'package:flutter/material.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:selling_point_app/generated/l10n.dart';

import 'custom_dialog_for_show_details.dart';

class DataRowOfTableShowAnotherSpOrder extends StatelessWidget {
  const DataRowOfTableShowAnotherSpOrder({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Material(
        color: const Color.fromARGB(255, 255, 255, 255),
        shadowColor: const Color.fromARGB(89, 197, 191, 191),
        elevation: 10,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  (index + 1).toString(),
                  textAlign: TextAlign.center,
                  style: Styles.textStyle18,
                ),
              ),
              Expanded(
                child: Text(
                  billCubit.billsOrderFromMe[index].createdAt.toString(),
                  textAlign: TextAlign.center,
                  style: Styles.textStyle18,
                ),
              ),
              Expanded(
                child: Text(
                  billCubit.billsOrderFromMe[index].fromSellPoint!.name
                      .toString(),
                  textAlign: TextAlign.center,
                  style: Styles.textStyle18,
                ),
              ),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          billCubit.fetchSpBill(
                              billCubit.billsOrderFromMe[index].toSellPointId!,
                              index);
                          return CustomDialogForShowDetails(
                            index: index,
                            date: billCubit.billsOrderFromMe[index].createdAt
                                .toString(),
                          );
                        },
                      );
                    },
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: AppColors.lightGreyBlue,
                    // ),
                    child: Text(
                      // ------------ details ----------------
                      S.of(context).showYourBillsBottomDetails,
                      // -------------------------------------
                      style: Styles.textStyle15Black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
