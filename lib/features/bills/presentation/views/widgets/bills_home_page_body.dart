import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/core/widgets/custom_primary_bottom.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:selling_point_app/features/bills/presentation/views/order_from_factory_page.dart';
import 'package:selling_point_app/features/bills/presentation/views/order_from_sp_page.dart';
import 'package:selling_point_app/features/bills/presentation/views/show_another_sp_order_page.dart';
import 'package:selling_point_app/features/bills/presentation/views/show_your_bills_page.dart';
import 'package:selling_point_app/generated/l10n.dart';
import 'package:intl/intl.dart';
import '../../../../../core/widgets/custom_text.dart';

class BillsHomePageBody extends StatelessWidget {
  const BillsHomePageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // order bill
                CustomPrimaryBottom(
                  // ------ order the bill --------
                  name: S.of(context).billBottomOrder,
                  // -------------------------------------------
                  icon: Icons.grading_outlined,
                  // ------------------ order now -----------------------
                  description:
                      S.of(context).billBottomOrderFromFactoryDescription,
                  // -----------------------------------------------------
                  onTap: () {
                    // billCubit.interToOrdersPages();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2021),
                                  lastDate: DateTime(2030),
                                ).then((value) {
                                  if (value != null) {
                                    billCubit.dateForOrder = value;
                                    billCubit.emit(BillPageInitial());
                                  }
                                });
                              },
                              child: const Text(
                                'اختر تاريخ',
                                // S.of(context).chooseDate,
                              ),
                            ),
                            BlocBuilder<BillPageCubit, BillPageState>(
                              builder: (context, state) {
                                return CustomText(
                                  data: DateFormat('yyyy-MM-dd', 'en').format(
                                    billCubit.dateForOrder,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        title: Text(
                          // --- choose An Order Type ------
                          S.of(context).chooseAnOrderType,
                          // --------------------------------
                          style: Styles.textStyle15DarkGreen,
                        ),
                        actions: [
                          // food order
                          ElevatedButton(
                            onPressed: () {
                              // billCubit.isStore = true;
                              billCubit.fetchActiveCategory();
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OrderFromFactoryPage(
                                    isStore: true,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              // --- Food Order ----
                              S.of(context).foodOrder,
                              // -------------------
                              style: Styles.textStyle13,
                            ),
                          ),
                          // Raw material order
                          ElevatedButton(
                            onPressed: () {
                              // billCubit.isStore = false;
                              billCubit.fetchActiveCategory();
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OrderFromFactoryPage(
                                    isStore: false,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              // ----- Raw materials order ----
                              S.of(context).rawMaterialsOrder,
                              // ------------------------------
                              style: Styles.textStyle13,
                            ),
                          ),

                          // return order
                          /*
                          ElevatedButton(
                            onPressed: () {
                              // billCubit.isStore = true;
                              billCubit.fetchActiveCategory();
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OrderFromFactoryPage(
                                    isStore: true,
                                    isNew: true,
                                    isReturn: true,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              // --- return order ----
                              S.of(context).returnOrder,
                              // -------------------
                              style: Styles.textStyle13,
                            ),
                          ),
                          */
                          // expenses order
                          /*
                          ElevatedButton(
                            onPressed: () {
                              // billCubit.isStore = true;
                              billCubit.fetchActiveCategory();
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OrderFromFactoryPage(
                                    isStore: true,
                                    isNew: true,
                                    isReturn: false,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              // --- expenses Order ----
                              S.of(context).expensesOrder,
                              // -------------------
                              style: Styles.textStyle13,
                            ),
                          ),
                          */
                          // external order
                          ElevatedButton(
                            onPressed: () {
                              // billCubit.isStore = true;
                              billCubit.fetchActiveCategory();
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OrderFromFactoryPage(
                                    isStore: true,
                                    isNew: true,
                                    isReturn: false,
                                    isExternal: true,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              // --- external Order ----
                              S.of(context).externalOrder,
                              // -------------------
                              style: Styles.textStyle13,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // order bill from another sp
                CustomPrimaryBottom(
                  // --- order the bill from another sp ---
                  name: S.of(context).billBottomOrderFromSp,
                  // --------------------------------------
                  icon: Icons.grading_outlined,
                  // -------------- order from near sp ----------------------
                  description: S.of(context).billBottomOrderFromSpDescription,
                  // --------------------------------------------------------
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: ElevatedButton(
                          child: const Text(
                            'choose date',
                            // S.of(context).chooseDate,
                          ),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2030),
                            ).then(
                              (value) {
                                if (value != null) {
                                  print(
                                      'date selected for order from another sell point : ${value.toIso8601String()}');
                                  billCubit.dateForOrderFromSp = value;

                                  billCubit.interToOrdersPages();
                                  Navigator.of(context).pop();

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OrderFromSpPage(),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).pop();
                                }
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // show your bills
                CustomPrimaryBottom(
                  // ---------- show your bills -------------
                  name: S.of(context).billBottomShowYourBills,
                  // ----------------------------------------
                  icon: Icons.store,
                  // ------------------ show your orders ----------------------
                  description: S.of(context).billBottomShowYourBillsDescription,
                  // ----------------------------------------------------------
                  onTap: () {
                    // if (billCubit.allBills.billsToFactory!.isEmpty &&
                    // billCubit.allBills.billsToSellPoint!.isEmpty) {
                    billCubit.fetchAllBills();
                    // }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ShowYourBillsPage(),
                      ),
                    );
                  },
                ),
                // another sp order
                CustomPrimaryBottom(
                  // ----------- another sp orders ---------------
                  name: S.of(context).billBottomShowAnotherSpOrder,
                  // ---------------------------------------------
                  icon: Icons.speaker_phone,
                  description:
                      S.of(context).billBottomShowAnotherSpOrderDescription,
                  onTap: () {
                    billCubit.fetchBillFromMe();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ShowAnotherSpOrderPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
