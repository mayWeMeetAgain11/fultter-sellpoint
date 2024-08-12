import 'package:flutter/material.dart';
import 'package:selling_point_app/core/widgets/card_of_item.dart';
import 'package:selling_point_app/features/home/presentation/manager/cubit/home_page_cubit.dart';
import 'package:selling_point_app/features/sale/presentation/manager/cubit/sale_page_cubit.dart';

import '../../../../loginAndStart/presentation/manager/cubit/login_and_start_cubit.dart';

class CustomSalePageBody extends StatelessWidget {
  const CustomSalePageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);
    HomePageCubit homeCubit = HomePageCubit.get(context);

    SalePageCubit saleCubit = SalePageCubit.get(context);

    return Expanded(
      flex: 3,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          saleCubit.cardController.add(TextEditingController(text: '1'));
          saleCubit.cardCounter.add(1);
          return CardOfItem(
            index: index,
            isOrder: false,
          );
        },
        itemCount: homeCubit.activeCategory.length,
      ),
      //  CardOfItem(),
    );
  }
}
