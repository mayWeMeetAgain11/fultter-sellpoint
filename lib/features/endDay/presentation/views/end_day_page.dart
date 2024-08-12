import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/constants.dart';
import 'package:selling_point_app/core/cache/cashe_helper.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/core/widgets/custom_left_side.dart';
import 'package:selling_point_app/features/endDay/presentation/manager/cubit/end_day_page_cubit.dart';
import 'package:selling_point_app/features/endDay/presentation/views/widgets/emvelope_page.dart';
import 'package:selling_point_app/features/endDay/presentation/views/widgets/end_day_page_body.dart';
import 'package:selling_point_app/features/endDay/presentation/views/widgets/inventory_page.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/views/start_page.dart';
import 'package:selling_point_app/features/sale/presentation/manager/cubit/sale_page_cubit.dart';
import 'package:selling_point_app/generated/l10n.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/custom_primary_bottom.dart';
import '../../../../core/widgets/custom_text.dart';

class EndDayPage extends StatelessWidget {
  const EndDayPage({super.key});

  @override
  Widget build(BuildContext context) {
    EndDayPageCubit endCubit = EndDayPageCubit.get(context);
    SalePageCubit saleCubit = SalePageCubit.get(context);

    // EndDayPageCubit endDayPageCubit = EndDayPageCubit.get(context);
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Row(
          children: [
            CustomLeftSide(
              canReturn: true,
              // ------- EndDay Page ---------
              title: S.of(context).endDayTitle,
              // -----------------------------
              endDay: false,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomPrimaryBottom(
                          // ----------- End Day -------------
                          name: "العينات و المرتجع",
                          // ---------------------------------
                          icon: Icons.error_rounded,
                          // -- enter the final amount and inventory your items --
                          description: "ادخل بيانات جرد جميع العنيات و المرتجع",
                          // -----------------------------------------------------
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Row(
                                  children: [
                                    ElevatedButton(
                                      child: const Text(
                                        'اختر تاريخ',
                                        // S.of(context).chooseDate,
                                        style: Styles.textStyle13,
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
                                                  'date selected for order from another sell point : ${DateFormat('yyyy-MM-dd', 'en').format(value)}');
                                              endCubit.dateFOrInventory = value;
                                              endCubit
                                                  .emit(EndDayPageInitial());
                                              // Navigator.of(context).pop();
                                              // Navigator.of(context).push(
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         const InventoryPage(),
                                              //   ),
                                              // );
                                            }
                                            // else {
                                            //   Navigator.of(context).pop();
                                            // }
                                          },
                                        );
                                      },
                                    ),
                                    BlocBuilder<EndDayPageCubit,
                                        EndDayPageState>(
                                      builder: (context, state) {
                                        return CustomText(
                                          data: DateFormat('yyyy-MM-dd', 'en')
                                              .format(
                                            endCubit.dateFOrInventory,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const InventoryPage(
                                            typeOfExpenses: 'expens_eco',
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'حالات اقتصادية',
                                      style: Styles.textStyle13,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const InventoryPage(
                                            typeOfExpenses: 'doctor',
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'عينات طبيب',
                                      style: Styles.textStyle13,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const InventoryPage(
                                                  typeOfExpenses: 'manager'),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'عينات ادارة',
                                      style: Styles.textStyle13,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const InventoryPage(
                                                  typeOfExpenses: 'default'),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'عينات مشرف',
                                      style: Styles.textStyle13,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const InventoryPage(
                                            typeOfExpenses: 'returns',
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'مرتجعات',
                                      style: Styles.textStyle13,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        CustomPrimaryBottom(
                          // ----------- End Day -------------
                          name: "الظرف",
                          // ---------------------------------
                          icon: Icons.error_rounded,
                          // -- enter the final amount and inventory your items --
                          description: "ادخل كمية الظرف",
                          // -----------------------------------------------------
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: ElevatedButton(
                                  child: const Text(
                                    'اختر تاريخ',
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
                                              'date selected for order from another sell point : ${DateFormat('yyyy-MM-dd', 'en').format(value)}');
                                          endCubit.dateFOrEnvelops = value;
                                          Navigator.of(context).pop();

                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const EnvelopePage(),
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

                        // CustomLeftSide(
                        //   canReturn: true,
                        //   // ------- EndDay Page ---------
                        //   title: S.of(context).endDayTitle,
                        //   // -----------------------------
                        //   endDay: true,
                        // ),
                        // const EndDayPageBody(),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomPrimaryBottom(
                          // ----------- End Day -------------
                          name: "الجرد",
                          // ---------------------------------
                          icon: Icons.error_rounded,
                          // -- enter the final amount and inventory your items --
                          description: "اجرد المتبقي",
                          // -----------------------------------------------------
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: ElevatedButton(
                                  child: const Text(
                                    'اختر تاريخ',
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
                                              'date selected for order from another sell point : ${DateFormat('yyyy-MM-dd', 'en').format(value)}');
                                          endCubit.dateFOrInventory = value;
                                          Navigator.of(context).pop();

                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const InventoryPage(),
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
                        CustomPrimaryBottom(
                          // ----------- End Day -------------
                          name: "إنهاء اليوم",
                          // ---------------------------------
                          icon: Icons.error_rounded,
                          // -- enter the final amount and inventory your items --
                          description: "انهي اليوم هنا",
                          // -----------------------------------------------------
                          onTap: () {
                            endCubit.invintoryController.clear();
                            endCubit.invintoryController = [];
                            // endCubit.takenController = [];
                            endCubit.invintoryController = [];
                            endCubit.envelopeAddress.clear();
                            endCubit.envelopeAmount.clear();
                            saleCubit
                                .deleteStudentsAndOrdersTablesFromDatabase();
                            CasheHelper.setData(
                                key: Constants.kfirstOrderFActory,
                                value: false);
                            CasheHelper.setData(
                                key: Constants.kfirstOrderSp, value: false);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StartPage(),
                              ),
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
