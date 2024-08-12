import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:selling_point_app/constants.dart';
import 'package:selling_point_app/core/cache/cashe_helper.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:selling_point_app/features/home/presentation/manager/cubit/home_page_cubit.dart';
import 'package:selling_point_app/features/sale/presentation/manager/cubit/sale_page_cubit.dart';


class CardOfItem extends StatelessWidget {
  const CardOfItem({
    super.key,
    required this.index,
    this.isOrder = true,
  });
  final int index;
  final bool isOrder;
  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    SalePageCubit saleCubit = SalePageCubit.get(context);
    HomePageCubit homeCubit = HomePageCubit.get(context);

    // TextEditingController a = TextEditingController(text: '0');
    // String urlPhoto = (homeCubit.activeCategory[index].photo == 'default')
    //     ? 'assets/image/image 1.jpg'
    //     : homeCubit.activeCategory[index].photo!;

    String urlPhoto = homeCubit.activeCategory[index].photo!;
    return Card(
      color: Colors.grey[300],
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              // width: 200,
              // height: 200,
              child: Material(
                color: Colors.grey[300],
                child: InkWell(
                  onTap: () {
                    String? itemName;
                    if (CasheHelper.getData(key: Constants.klangSympol) ==
                        'en') {
                      itemName = homeCubit.activeCategory[index].nameEn;
                    } else {
                      itemName = homeCubit.activeCategory[index].nameAr;
                    }
                    double price = double.parse(
                      homeCubit.activeCategory[index].price.toString(),
                    );

                    (isOrder)
                        ? billCubit.addToSelectedItem(
                            index,
                            itemName!,
                            price,
                            homeCubit.activeCategory[index].id!,
                          )
                        : saleCubit.addToSelectedItem(
                            index,
                            itemName!,
                            price,
                            homeCubit.activeCategory[index].id!,
                          );

                    print(index.toString());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: urlPhoto == 'default'
                          ? const Image(
                              height: 180,
                              width: 180,
                              image: AssetImage(
                                'assets/image/shamseen.png',
                              ),
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              height: 180,
                              width: 180,
                              fit: BoxFit.cover,
                              imageUrl: '${Constants.kDomin}$urlPhoto',
                              placeholder: (context, url) =>
                                  const SpinKitSpinningLines(
                                size: 140,
                                color: AppColors.green1,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                size: 50,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text(
                        // ------------ name of item ------------
                        (CasheHelper.getData(key: Constants.klangSympol) ==
                                'en')
                            ? homeCubit.activeCategory[index].nameEn!
                            : homeCubit.activeCategory[index].nameAr!,
                        // -------------------------------------
                        style: Styles.textStyle16,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    homeCubit.activeCategory[index].price.toString(),
                    style: Styles.textStyle13,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            // const Expanded(child: SizedBox()),
            // SizedBox(
            //   height: 30,
            // ),
            SizedBox(
              // width: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // FloatingActionButton(
                  //   backgroundColor: AppColors.green2,
                  //   mini: true,
                  //   onPressed: () {
                  //     print('object');
                  //     print(data);
                  //   },
                  //   // heroTag: 'age++',
                  //   child: const Icon(
                  //     Icons.remove,
                  //     color: AppColors.white,
                  //   ),
                  // ),
                  IconButton(
                    onPressed: () {
                      (isOrder)
                          ? billCubit.decreaseCounter(index)
                          : saleCubit.decreaseCounter(index);
                    },
                    icon: const Icon(Icons.remove),
                    color: AppColors.black,
                    highlightColor: AppColors.lightGreyBlue,
                  ),
                  (isOrder)
                      ? SizedBox(
                          width: 70,
                          child: BlocBuilder<BillPageCubit, BillPageState>(
                            builder: (context, state) {
                              return TextField(
                                controller: billCubit.cardController[index],
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onTap: () {
                                  billCubit.onTapCounterChange(index);

                                  // print(ourCubit.cardController.length);
                                  // print(ourCubit.cardCounter.length);
                                  // print(222);
                                },
                                onChanged: (value) {
                                  billCubit.onChangedCounter(index, value);
                                },
                                onSubmitted: (value) {
                                  print(billCubit.cardCounter[index]);
                                },
                              );
                            },
                          ),
                        )
                      : SizedBox(
                          width: 70,
                          child: BlocBuilder<SalePageCubit, SalePageState>(
                            builder: (context, state) {
                              return TextField(
                                controller: saleCubit.cardController[index],
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onTap: () {
                                  saleCubit.onTapCounterChange(index);
                                  // print(ourCubit.cardController.length);
                                  // print(ourCubit.cardCounter.length);
                                  // print(222);
                                },
                                onChanged: (value) {
                                  saleCubit.onChangedCounter(index, value);
                                },
                                onSubmitted: (value) {
                                  print(saleCubit.cardCounter[index]);
                                },
                              );
                            },
                          ),
                        ),

                  IconButton(
                    onPressed: () {
                      (isOrder)
                          ? billCubit.increaseCounter(index)
                          : saleCubit.increaseCounter(index);
                    },
                    icon: const Icon(Icons.add),
                    color: AppColors.black,
                    highlightColor: AppColors.lightGreyBlue,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
