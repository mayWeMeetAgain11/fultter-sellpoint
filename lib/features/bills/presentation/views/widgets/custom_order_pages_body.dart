import 'package:flutter/material.dart';
import 'package:selling_point_app/core/widgets/card_of_item.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:selling_point_app/features/home/presentation/manager/cubit/home_page_cubit.dart';

class CustomOrderPagesBody extends StatelessWidget {
  const CustomOrderPagesBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    // LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);
    HomePageCubit homeCubit = HomePageCubit.get(context);
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
          billCubit.cardController.add(TextEditingController(text: '1'));
          billCubit.cardCounter.add(1);
          return CardOfItem(index: index);
        },
        itemCount: homeCubit.activeCategory.length,
      ),
      //  CardOfItem(),
    );
  }
}
