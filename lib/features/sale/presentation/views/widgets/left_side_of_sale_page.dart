import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/custom_Loading_indicator.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/core/widgets/custom_error_widget.dart';
import 'package:selling_point_app/core/widgets/custom_left_orderd_saled_item.dart';
import 'package:selling_point_app/core/widgets/custom_text.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/left_side_of_order_pages.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/manager/cubit/login_and_start_cubit.dart';
import 'package:selling_point_app/features/sale/presentation/manager/cubit/sale_page_cubit.dart';
import 'package:selling_point_app/features/sale/presentation/views/widgets/student_info.dart';
import 'package:selling_point_app/features/sale/presentation/views/widgets/tail_of_side.dart';
import 'package:selling_point_app/features/sale/presentation/views/widgets/title_and_back_arrow.dart';
import 'package:selling_point_app/generated/l10n.dart';

class LeftSideOfSalePage extends StatelessWidget {
  const LeftSideOfSalePage({
    super.key,
    required this.title,
    required this.isOffline,
  });
  final String title;
  final bool isOffline;
  @override
  Widget build(BuildContext context) {
    SalePageCubit saleCubit = SalePageCubit.get(context);
    LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);

    double width = MediaQuery.of(context).size.width;

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
            TitleAndbackArrow(title: title),
            Expanded(
              flex: 3,
              child: BlocBuilder<SalePageCubit, SalePageState>(
                builder: (context, state) {
                  List<MapEntry<int, SelectedItem>> entryList =
                      saleCubit.selectedItem.entries.toList();
                  print(entryList);
                  return ListView.builder(
                    controller: saleCubit.scrollController,
                    itemCount:
                        entryList.length, //saleCubit.selectedItem.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(
                          // loginCubit.activeCategory[index].id.toString()
                          entryList[index].key.toString(),
                        ),
                        child: CustomLeftOrderdSaledItem(
                          index: index,
                          itemName: entryList[index]
                              .value
                              .title!, //saleCubit.selectedItem[index]!.title!,
                          price: double.parse(
                              entryList[index].value.price.toString()),
                          // double.parse(
                          // saleCubit.selectedItem[index]!.price.toString()),
                          quantity: entryList[index].value.quantity!,
                          // saleCubit.selectedItem[index]!.quantity!,
                        ),
                        onDismissed: (direction) {
                          // print('indfdgdfex $index');
                          // saleCubit.l.removeAt(index);

                          saleCubit.deleteFromSelectedItem(entryList[index].key
                              // entryList[index].key,
                              );

                          // saleCubit.emit(BillPageInitial());
                          print('dismisss $index');
                          // l.remove('sdf');
                          // print(l.length);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            BlocBuilder<SalePageCubit, SalePageState>(
              builder: (context, state) {
                return CustomText(
                  // --------- total ----------
                  data: '${S.of(context).total} ${saleCubit.total}',
                  // --------------------------
                  style: Styles.textStyle13,
                );
              },
            ),
            const Divider(),
            StudentInfo(isOffline: isOffline),
            TailOfSide(isOffline: isOffline),
          ],
        ),
      ),
    );
  }
}
