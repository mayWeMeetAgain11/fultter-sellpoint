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

class CardOfItemOrderFactory extends StatelessWidget {
  const CardOfItemOrderFactory({
    super.key,
    required this.index,
    required this.isStore,
    // this.isOrder = true,
  });
  final int index;
  final bool isStore;
  // final bool isOrder;
  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    // SalePageCubit saleCubit = SalePageCubit.get(context);
    // HomePageCubit homeCubit = HomePageCubit.get(context);

    // TextEditingController a = TextEditingController(text: '0');
    // String urlPhoto = (homeCubit.activeCategory[index].photo == 'default')
    //     ? 'assets/image/image 1.jpg'
    //     : homeCubit.activeCategory[index].photo!;

    String urlPhoto = (isStore)
        ? billCubit.currentActiveCategory[index].photo!
        : billCubit.activeCategoryRaw[index].photo!;
    return Card(
      color: Colors.grey[300],
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      itemName = (isStore)
                          ? billCubit.currentActiveCategory[index].nameEn
                          : billCubit.activeCategoryRaw[index].nameEn;
                    } else {
                      itemName = (isStore)
                          ? billCubit.currentActiveCategory[index].nameAr
                          : billCubit.activeCategoryRaw[index].nameAr;
                    }
                    double price = (isStore)
                        ? double.parse(
                            billCubit.currentActiveCategory[index].price
                                .toString(),
                          )
                        : double.parse(
                            billCubit.activeCategoryRaw[index].price.toString(),
                          );

                    int id = (isStore)
                        ? billCubit.currentActiveCategory[index].id!
                        : billCubit.activeCategoryRaw[index].id!;
                    billCubit.addToSelectedItem(
                      index,
                      itemName!,
                      price,
                      id,
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
                            ? (isStore)
                                ? billCubit.currentActiveCategory[index].nameEn!
                                : billCubit.activeCategoryRaw[index].nameEn!
                            : ((isStore))
                                ? billCubit.currentActiveCategory[index].nameAr!
                                : billCubit.activeCategoryRaw[index].nameAr!,
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
                    (isStore)
                        ? billCubit.currentActiveCategory[index].price
                            .toString()
                        : billCubit.activeCategoryRaw[index].price.toString(),
                    style: Styles.textStyle13,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      billCubit.decreaseCounter(index);
                    },
                    icon: const Icon(Icons.remove),
                    color: AppColors.black,
                    highlightColor: AppColors.lightGreyBlue,
                  ),
                  SizedBox(
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
                  ),
                  IconButton(
                    onPressed: () {
                      billCubit.increaseCounter(index);
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
