import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/constants.dart';
import 'package:selling_point_app/core/cache/cashe_helper.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/custom_Loading_indicator.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/core/widgets/custom_error_widget.dart';
import 'package:selling_point_app/core/widgets/custom_text.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';

class CustomDialogForShowDetails extends StatelessWidget {
  const CustomDialogForShowDetails({
    super.key,
    required this.index,
    required this.date,
  });
  final int index;
  final String date;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.grey[300],
      child: SizedBox(
        height: height - 10,
        width: width - 500,
        child: BlocBuilder<BillPageCubit, BillPageState>(
          builder: (context, state) {
            if (state is LoadingGetSingleBillState) {
              return const CustomLoadingIndicator(
                color: AppColors.green1,
              );
            } else if (state is FailureBillState) {
              return CustomErrorWidget(errMessage: state.errMessage);
            } else if (state is SuccessToFactoryBillState) {
              return DialogDetailsBody(
                billIndex: index,
                date: date,
              );
            } else if (state is SuccessToSpBillState) {
              return DialogDetailsBodySp(
                billIndex: index,
                date: date,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class DialogDetailsBody extends StatelessWidget {
  const DialogDetailsBody({
    super.key,
    required this.billIndex,
    required this.date,
  });
  final int billIndex;
  final String date;
  @override
  Widget build(BuildContext context) {
    String lang = CasheHelper.getData(key: Constants.klangSympol);
    BillPageCubit billCubit = BillPageCubit.get(context);
    return Column(
      children: [
        Expanded(
          child: CustomText(
            data: date,
            color: AppColors.green1,
            style: Styles.textStyle18White,
          ),
        ),
        Expanded(
          flex: 8,
          child: ListView.builder(
            itemBuilder: (context, index) {
              String catName = (lang == 'en')
                  ? billCubit
                      .detailsOfFActoryBill[billIndex]![index].category!.nameEn!
                  : billCubit.detailsOfFActoryBill[billIndex]![index].category!
                      .nameAr!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: AppColors.green1,
                  shadowColor: const Color.fromARGB(89, 197, 191, 191),
                  elevation: 10,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              catName,
                              maxLines: 1,
                              style: Styles.textStyle18White,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'quantity',
                              style: Styles.textStyle18White,
                            ),
                            Text(
                              billCubit.detailsOfFActoryBill[billIndex]![index]
                                  .amount
                                  .toString(),
                              style: Styles.textStyle18White,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'prirce',
                              style: Styles.textStyle18White,
                            ),
                            Text(
                              billCubit.detailsOfFActoryBill[billIndex]![index]
                                  .totalPrice
                                  .toString(),
                              style: Styles.textStyle18White,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: billCubit.detailsOfFActoryBill[billIndex]!.length,
          ),
        ),
        const Divider(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ),
        )
      ],
    );
  }
}

class DialogDetailsBodySp extends StatelessWidget {
  const DialogDetailsBodySp({
    super.key,
    required this.billIndex,
    required this.date,
  });
  final int billIndex;
  final String date;
  @override
  Widget build(BuildContext context) {
    String lang = CasheHelper.getData(key: Constants.klangSympol);
    BillPageCubit billCubit = BillPageCubit.get(context);
    return Column(
      children: [
        Expanded(
          child: CustomText(
            data: date,
            color: AppColors.green1,
            style: Styles.textStyle18White,
          ),
        ),
        Expanded(
          flex: 8,
          child: ListView.builder(
            itemBuilder: (context, index) {
              String catName = (lang == 'en')
                  ? billCubit
                      .detailsOfSpBill[billIndex]![index].category!.nameEn!
                  : billCubit
                      .detailsOfSpBill[billIndex]![index].category!.nameAr!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: AppColors.green1,
                  shadowColor: const Color.fromARGB(89, 197, 191, 191),
                  elevation: 10,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              catName,
                              maxLines: 1,
                              style: Styles.textStyle18White,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'quantity',
                              style: Styles.textStyle18White,
                            ),
                            Text(
                              billCubit
                                  .detailsOfSpBill[billIndex]![index].amount
                                  .toString(),
                              style: Styles.textStyle18White,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'prirce',
                              style: Styles.textStyle18White,
                            ),
                            Text(
                              billCubit
                                  .detailsOfSpBill[billIndex]![index].totalPrice
                                  .toString(),
                              style: Styles.textStyle18White,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: billCubit.detailsOfSpBill[billIndex]!.length,
          ),
        ),
        const Divider(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ),
        )
      ],
    );
  }
}
