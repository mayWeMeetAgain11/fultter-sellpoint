import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/features/sale/presentation/views/widgets/custom_sale_dialog.dart';

import '../../../../../core/utils/custom_Loading_indicator.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../bills/presentation/views/widgets/left_side_of_order_pages.dart';
import '../../manager/cubit/sale_page_cubit.dart';
import 'left_side_of_sale_page.dart';

class TailOfSide extends StatelessWidget {
  const TailOfSide({
    super.key,
    required this.isOffline,
  });

  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    SalePageCubit saleCubit = SalePageCubit.get(context);

    return BlocBuilder<SalePageCubit, SalePageState>(
      builder: (context, state) {
        if (state is LoadingFetchAllStudent) {
          return const SizedBox();
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (saleCubit.selectedItem.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => CustomSaleDialog(
                        // ----- Please select an item ----
                        text: S.of(context).errorDialogItem,
                        // --------------------------------
                      ),
                    );
                  } else if (saleCubit.student.id == null && !isOffline) {
                    showDialog(
                      context: context,
                      builder: (context) => CustomSaleDialog(
                        // --- please choose student --------
                        text: S.of(context).errorDialogStudent,
                        // ----------------------------------
                      ),
                    );
                  } else if (saleCubit.studentOffline.id == null && isOffline) {
                    showDialog(
                      context: context,
                      builder: (context) => CustomSaleDialog(
                        // --- please choose student --------
                        text: S.of(context).errorDialogStudent,
                        // ----------------------------------
                      ),
                    );
                  } else if ((saleCubit.student.balance < saleCubit.total ||
                          saleCubit.student.threshold < saleCubit.total) &&
                      !isOffline) {
                    print('onlinnnne');
                    showDialog(
                      context: context,
                      builder: (context) => CustomSaleDialog(
                        // ---- Daily limit or balance is not enough----
                        text: S.of(context).errorDialogBalance,
                        // ---------------------------------------------
                      ),
                    );
                  } else if ((saleCubit.studentOffline.balance <
                              saleCubit.total ||
                          saleCubit.studentOffline.totalPrice <
                              saleCubit.total) &&
                      isOffline) {
                    print('offfffline');
                    showDialog(
                      context: context,
                      builder: (context) => CustomSaleDialog(
                        // ---- Daily limit or balance is not enough----
                        text: S.of(context).errorDialogBalance,
                        // ---------------------------------------------
                      ),
                    );
                  } else {
                    if (isOffline) {
                      List<MapEntry<int, SelectedItem>> entryList =
                          saleCubit.selectedItem.entries.toList();
                      print(entryList.length);
                      for (var i = 0; i < entryList.length; i++) {
                        await saleCubit.insertOrderToDatabase(
                          saleCubit.database2,
                          entryList[i].value,
                          saleCubit.studentOffline.id!,
                          DateTime.now().toIso8601String(),
                        );
                      }
                      // }
                      await saleCubit.updateStudentsDatabase(
                        saleCubit.studentOffline.balance - saleCubit.total,
                        saleCubit.studentOffline.id!,
                        saleCubit.studentOffline.totalPrice - saleCubit.total,
                      );
                      saleCubit.total = 0;
                      saleCubit.selectedItem.clear();
                    } else {
                      List<Map<String, int>> bodyBillToSend = [];
                      saleCubit.selectedItem.forEach((key, value) {
                        bodyBillToSend.add({
                          "category_id": value.id!,
                          "amount": value.quantity!,
                        });
                      });
                      Map<String, dynamic> billToSend = {
                        "student_id": saleCubit.student.id,
                        "total_price": saleCubit.total,
                        "bills": bodyBillToSend
                      };
                      showDialog(
                        context: context,
                        builder: (context) => FailANdSuccessSAleDialog(),
                      );
                      await saleCubit.postBillOnline(billToSend);

                      // saleCubit
                      //     .fetchOneStudent(saleCubit.student.id.toString());
                      saleCubit.selectedItem.clear();
                    }
                  }
                },
                // ---------- post ------------
                child: Text(S.of(context).post),
                // ----------------------------
              ),
              ElevatedButton(
                onPressed: () async {
                  await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666',
                    'cancel',
                    true,
                    ScanMode.QR,
                  ).then((value) {
                    if (value == '-1') {
                      // saleCubit.getStudentFromDatabase(
                      // saleCubit.database2, '1000045');
                      // print('you don\'t choose a studet');
                      // saleCubit.fetchOneStudent('1000045');
                    } else {
                      if (isOffline) {
                        saleCubit.getStudentFromDatabase(
                            saleCubit.database2, value);
                      } else {
                        saleCubit.fetchOneStudent(value);
                      }
                      print(' value is $value');
                    }
                  }).catchError((Error) {
                    print('error00000000000 $Error');
                  });

                  // try {
                  //   barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  //     '#ff6666',
                  //     'cancel',
                  //     true,
                  //     ScanMode.QR,
                  //   ) . then((value) {

                  //   });

                  //   print('par code : $barcodeScanRes');
                  // } on PlatformException catch (e) {
                  //   print('exception $e');
                  // }
                },
                child: Text(
                  // --- choose student ----
                  S.of(context).chooseStudent,
                  // -----------------------
                ),
              )
            ],
          );
        }
      },
    );
  }
}

class FailANdSuccessSAleDialog extends StatelessWidget {
  const FailANdSuccessSAleDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SalePageCubit saleCubit = SalePageCubit.get(context);
    return AlertDialog(
      content: BlocBuilder<SalePageCubit, SalePageState>(
        builder: (context, state) {
          if (state is LoadingSaleOrder) {
            return const CustomLoadingIndicator(
              color: AppColors.green1,
            );
          } else if (state is FailureSaleOrder) {
            saleCubit.total = 0;
            return CustomErrorWidget(
              textStyle: Styles.textStyle18,
              iconColor: AppColors.green1,
              // ---------- there is an error ---------
              errMessage: state.errMessage,
              // --------------------------------------
            );
          } else if (state is SuccessSaleOrder) {
            saleCubit.fetchOneStudent(saleCubit.student.id.toString());
            Navigator.of(context).pop();
            saleCubit.total = 0;
            return const Icon(
              Icons.done_all,
              size: 80,
              color: Colors.green,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
