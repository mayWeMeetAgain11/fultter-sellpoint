import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/custom_dialog_for_show_details.dart';
import 'package:selling_point_app/generated/l10n.dart';

class DataRowOfTableOfShowYourBills extends StatelessWidget {
  const DataRowOfTableOfShowYourBills({
    super.key,
    required this.index,
    required this.bills,
  });
  final int index;
  final bills;
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    BillPageCubit billCubit = BillPageCubit.get(context);
    int indexx = index + 1;
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
                  indexx.toString(),
                  textAlign: TextAlign.center,
                  style: Styles.textStyle18,
                ),
              ),
              BlocBuilder<BillPageCubit, BillPageState>(
                builder: (context, state) {
                  if (state is SuccessToSpBillState) {
                    return const Expanded(
                      child: Text(
                        '', // bills[index].fromSellPoint.id,
                        style: Styles.textStyle14,
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              Expanded(
                child: Text(
                  bills[index].createdAt.toString(),
                  textAlign: TextAlign.center,
                  style: Styles.textStyle18,
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          if (billCubit.state is SuccessToFactoryBillState) {
                            if (billCubit.detailsOfFActoryBill[index] == null) {
                              billCubit.fetchFactoryBill(
                                  bills[index].id, index);
                            }
                          } else {
                            if (billCubit.detailsOfSpBill[index] == null) {
                              print('55555');
                              billCubit.fetchSpBill(bills[index].id, index);
                            }
                          }

                          return CustomDialogForShowDetails(
                            index: index,
                            date: bills[index].createdAt.toString(),
                          );
                        },
                      );
                    },
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: AppColors.lightGreyBlue,
                    // ),
                    child: Text(
                      // -------------- details --------------
                      S.of(context).showYourBillsBottomDetails,
                      // -------------------------------------
                      style: Styles.textStyle15Black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
