import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/constants.dart';
import 'package:selling_point_app/core/cache/cashe_helper.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/custom_Loading_indicator.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/core/widgets/custom_error_widget.dart';
import 'package:selling_point_app/core/widgets/custom_left_orderd_saled_item.dart';
import 'package:selling_point_app/core/widgets/custom_text.dart';
import 'package:selling_point_app/core/widgets/custom_text_form_field.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:selling_point_app/generated/l10n.dart';
import 'package:intl/intl.dart';

import '../../../data/models/sell_point.dart';

class LeftSideOfOrderPages extends StatelessWidget {
  const LeftSideOfOrderPages({
    super.key,
    required this.title,
    this.toSp = false,
    required this.isStore,
    this.isReturn = true,
    this.isNew = false,
    required this.isExternal,
  });
  final bool? toSp;
  final String title;
  final bool isStore;
  final bool isReturn;
  final bool isNew;
  final bool isExternal;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    BillPageCubit billCubit = BillPageCubit.get(context);

    return ClipRRect(
      borderRadius: const BorderRadiusDirectional.only(
        topEnd: Radius.circular(20),
        bottomEnd: Radius.circular(20),
      ),
      child: Container(
        color: AppColors.green1,
        width: width * .25,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              color: AppColors.green2,
              width: double.infinity,
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: ElevatedButton(
                          onPressed: () {
                            billCubit.backToPrevious(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColors.green1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        title,
                        // textAlign: textAlign,
                        style: Styles.textStyle18White,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<BillPageCubit, BillPageState>(
                builder: (context, state) {
                  List<MapEntry<int, SelectedItem>> entryList =
                      billCubit.selectedItem.entries.toList();
                  return ListView.builder(
                    controller: billCubit.scrollController,
                    itemCount:
                        entryList.length, //billCubit.selectedItem.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(entryList[index].key.toString()),
                        child: CustomLeftOrderdSaledItem(
                          index: index,
                          itemName: entryList[index]
                              .value
                              .title!, //billCubit.selectedItem[index]!.title!,
                          price: double.parse(
                            entryList[index].value.price.toStringAsFixed(2),
                          ),
                          // double.parse(
                          // billCubit.selectedItem[index]!.price.toString()),
                          quantity: entryList[index].value.quantity!,
                          // billCubit.selectedItem[index]!.quantity!,
                        ),
                        onDismissed: (direction) {
                          // billCubit.l.removeAt(index);
                          billCubit
                              .deleteFromSelectedItem(entryList[index].key);
                          // billCubit.emit(BillPageInitial());
                          print('dismis $index');
                          // l.remove('sdf');
                          // print(l.length);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            BlocBuilder<BillPageCubit, BillPageState>(
              builder: (context, state) {
                if (state is LoadingPostToFactoryBillState && !toSp!) {
                  return const CustomLoadingIndicator();
                } else if (state is LoadingPostToSpBillState && toSp!) {
                  return const CustomLoadingIndicator();
                } else if (state is FailurePostData) {
                  return CustomErrorWidget(
                    // ------ 'you can't send your bill ' ---------
                    // errMessage: S.of(context).errorMessegeInPostBill,
                    errMessage: state.errMessage,
                    //----------------------------------------------
                  );
                } else if (state is SuccessPostBill) {
                  billCubit.selectedItem = {};
                  return Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.done_all,
                      color: Colors.green,
                      size: 80,
                    ),
                  );
                } else {
                  return CustomText(
                    // --------- total ----------
                    data:
                        '${S.of(context).total} ${billCubit.total.toStringAsFixed(2)}',
                    // --------------------------
                  );
                }
              },
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (toSp!)
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      width: 120,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (billCubit.allSellPoints.isEmpty) {
                            billCubit.fetchSellPoints();
                          }
                          showDialog(
                            context: context,
                            builder: (context) => const DialogAllSellPoints(),
                          );
                        },
                        // ------------------ choose Sp ------------------
                        child: Text(
                          S.of(context).orderFromFactoryChooseSP,
                          textAlign: TextAlign.center,
                          style: Styles.textStyle13,
                        ),
                        // -----------------------------------------------
                      ),
                    ),
                  )
                else
                  const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: 120,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        List<Map<String, int>> bodyBillToSend = [];
                        Map<String, dynamic> billToSend = {};

                        if (toSp!) {
                          if (billCubit.selectedItem.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text(
                                  S.of(context).loginValidateMessage,
                                  style: Styles.textStyle18,
                                ),
                              ),
                            );
                          } else {
                            if (billCubit.selectedSellPoint.id == null) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Row(
                                    children: [
                                      CustomText(
                                        // please Choose Sell point
                                        data: S.of(context).alertPostDialog,
                                      ),
                                      const Icon(
                                        Icons.error_outline,
                                        color: AppColors.red,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(S.of(context).ok),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              billCubit.selectedItem.forEach((key, value) {
                                bodyBillToSend.add({
                                  "category_id": value.id!,
                                  "amount": value.quantity!,
                                });
                              });
                              billToSend = {
                                'bills': bodyBillToSend,
                                "date": DateFormat('yyyy-MM-dd', 'en').format(
                                  billCubit.dateForOrderFromSp,
                                )
                              };
                              print(billToSend);

                              if (CasheHelper.getData(
                                  key: Constants.kfirstOrderSp)) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: CustomText(
                                      // ---------- aleart dialog message --------
                                      data: S.of(context).aleartDialogOfOrder,
                                      // -----------------------------------------
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          billCubit.postBillToSP(
                                            billCubit.selectedSellPoint.id!,
                                            billToSend,
                                          );
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          S.of(context).ok,
                                          style: Styles.textStyle13,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.red,
                                        ),
                                        child: Text(
                                          S.of(context).cancel,
                                          style: Styles.textStyle13White,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                CasheHelper.setData(
                                    key: Constants.kfirstOrderSp, value: true);
                                billCubit.postBillToSP(
                                  billCubit.selectedSellPoint.id!,
                                  billToSend,
                                );
                              }
                            }
                          }
                        } else {
                          if (billCubit.selectedItem.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text(
                                  S.of(context).loginValidateMessage,
                                  style: Styles.textStyle18,
                                ),
                              ),
                            );
                          } else {
                            if (isNew) {
                              if (isReturn) {
                                billCubit.selectedItem.forEach((key, value) {
                                  bodyBillToSend.add({
                                    "category_id": value.id!,
                                    "amount": value.quantity!,
                                  });
                                });
                                billToSend = {
                                  'type': 'returns',
                                  'bills': bodyBillToSend,
                                  'date': DateFormat('yyyy-MM-dd', 'en')
                                      .format(billCubit.dateForOrder),
                                };
                              } else if (isExternal) {
                                billCubit.selectedItem.forEach((key, value) {
                                  bodyBillToSend.add({
                                    "category_id": value.id!,
                                    "amount": value.quantity!,
                                  });
                                });
                                billToSend = {
                                  'type': 'external',
                                  'bills': bodyBillToSend,
                                  'date': DateFormat('yyyy-MM-dd', 'en')
                                      .format(billCubit.dateForOrder),
                                };
                              } else {
                                billCubit.selectedItem.forEach((key, value) {
                                  bodyBillToSend.add({
                                    "category_id": value.id!,
                                    "amount": value.quantity!,
                                  });
                                });
                                billToSend = {
                                  'type': 'expenses',
                                  'bills': bodyBillToSend,
                                  'date': DateFormat('yyyy-MM-dd', 'en')
                                      .format(billCubit.dateForOrder),
                                };
                              }
                              // print("bill to send is : $billToSend");
                              billCubit.postBillToFActory(billToSend);
                            } else {
                              if (isStore) {
                                billCubit.selectedItem.forEach((key, value) {
                                  bodyBillToSend.add({
                                    "category_id": value.id!,
                                    "amount": value.quantity!,
                                  });
                                });
                                billToSend = {
                                  'bills': bodyBillToSend,
                                  'type': 'default',
                                  'date': DateFormat('yyyy-MM-dd', 'en')
                                      .format(billCubit.dateForOrder),
                                };
                              } else {
                                billCubit.selectedItem.forEach((key, value) {
                                  bodyBillToSend.add({
                                    "category_id": value.id!,
                                    "amount": value.quantity!,
                                  });
                                });
                                billToSend = {
                                  'type': 'raw',
                                  'bills': bodyBillToSend,
                                  'date': DateFormat('yyyy-MM-dd', 'en')
                                      .format(billCubit.dateForOrder),
                                };
                              }
                              // if (CasheHelper.getData(
                              //   key: Constants.kfirstOrderFActory,
                              // )) {
                              //   showDialog(
                              //     context: context,
                              //     builder: (context) => AlertDialog(
                              //       content: CustomText(
                              //         // ---------- aleart dialog message --------
                              //         data: S.of(context).aleartDialogOfOrder,
                              //         // -----------------------------------------
                              //       ),
                              //       actions: [
                              //         ElevatedButton(
                              //           onPressed: () {
                              //             billCubit.postBillToFActory(billToSend);
                              //             Navigator.of(context).pop();
                              //           },
                              //           child: Text(
                              //             S.of(context).ok,
                              //             style: Styles.textStyle13,
                              //           ),
                              //         ),
                              //         ElevatedButton(
                              //           onPressed: () {
                              //             Navigator.of(context).pop();
                              //           },
                              //           style: ElevatedButton.styleFrom(
                              //             backgroundColor: AppColors.red,
                              //           ),
                              //           child: Text(
                              //             S.of(context).cancel,
                              //             style: Styles.textStyle13White,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   );
                              // } else

                              CasheHelper.setData(
                                  key: Constants.kfirstOrderFActory,
                                  value: true);
                              // if (isStore && !isNew) {
                              //   // if (CasheHelper.getData(
                              //   //     key: Constants.kIsOrdered)) {
                              //   showDialog(
                              //     context: context,
                              //     builder: (context) => const AlertDialog(
                              //       title: Text(
                              //         'لقد طلبت فاتورة اليوم, يرجى انهاء اليوم لتتمكن من طلب فاتورة غد',
                              //         style: Styles.textStyle15DarkGreen,
                              //       ),
                              //     ),
                              //   );
                              //   // } else {
                              //   //   billCubit.postBillToFActory(billToSend);
                              //   // }
                              // } else {
                              billCubit.postBillToFActory(billToSend);
                              // }
                            }
                          }
                        }
                      },
                      child: Text(
                        // ---- post -----
                        S.of(context).post,
                        // ---------------
                        style: Styles.textStyle14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (toSp!)
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<BillPageCubit, BillPageState>(
                  builder: (context, state) {
                    return CustomText(
                      data:
                          '${S.of(context).orderFromFactorySPChoosen} :  ${billCubit.selectedSellPoint.name}',
                      style: Styles.textStyle15SB,
                    );
                  },
                ),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class DialogAllSellPoints extends StatelessWidget {
  const DialogAllSellPoints({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      child: SizedBox(
        height: height,
        width: width * 0.4,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<BillPageCubit, BillPageState>(
                builder: (context, state) {
                  if (state is LoadingBillState) {
                    return const CustomLoadingIndicator(
                      color: AppColors.green1,
                    );
                  } else if (state is FailureBillState) {
                    return CustomErrorWidget(
                      errMessage: state.errMessage,
                      iconColor: AppColors.green1,
                      textStyle: Styles.textStyle23DarkGreen,
                    );
                  } else {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextFormField(
                            controller: null,
                            hintText: S.of(context).search,
                            onTap: (x) {},
                            onChange: (x) {
                              List<SellPoint> result =
                                  billCubit.allSellPoints.where((element) {
                                return element.name!
                                    .toLowerCase()
                                    .contains(x.toLowerCase());
                              }).toList();
                              billCubit.currentAllSellPoints = result;
                              billCubit.emit(SuccessGetSellPoints());
                            },
                          ),
                        ),
                        Expanded(
                          child: BlocBuilder<BillPageCubit, BillPageState>(
                            builder: (context, state) {
                              return ListView.builder(
                                itemCount:
                                    billCubit.currentAllSellPoints.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () {
                                        print(
                                            'sell point id: ${billCubit.currentAllSellPoints[index].id}');
                                        billCubit.selectedSellPoint = billCubit
                                            .currentAllSellPoints[index];
                                        print(
                                            'selected sellpoint   ${billCubit.selectedSellPoint.name}');
                                        billCubit.emit(SuccessGetSellPoints());
                                      },
                                      child: CustomText(
                                        data: billCubit
                                            .currentAllSellPoints[index].name!,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  // else {
                  //   return const SizedBox();
                  // }
                },
              ),
            ),
            const Divider(),
            SizedBox(
              // width: double.infinity,
              child: BlocBuilder<BillPageCubit, BillPageState>(
                builder: (context, state) {
                  return CustomText(
                    data:
                        '${S.of(context).orderFromFactorySPChoosen} :  ${billCubit.selectedSellPoint.name}',
                    style: Styles.textStyle15SB,
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        billCubit.currentAllSellPoints =
                            billCubit.allSellPoints;
                      },
                      child: Text(
                        S.of(context).ok,
                        style: Styles.textStyle15DarkGreen,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        billCubit.dialogBack(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                      ),
                      child: Text(
                        // ----- cancel ----
                        S.of(context).cancel,
                        // -----------------
                        style: Styles.textStyle15White,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// string double int
class SelectedItem {
  int? id;
  String? title;
  int? quantity;
  var price;

  SelectedItem({this.title, this.price, this.quantity, this.id});
}
