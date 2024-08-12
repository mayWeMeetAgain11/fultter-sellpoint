import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/core/widgets/custom_text_form_field.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';

import '../../../../../generated/l10n.dart';
import 'card_of_item_order_factory.dart';

class CustomOrderPagesBodyFactory extends StatelessWidget {
  const CustomOrderPagesBodyFactory({
    super.key,
    required this.isStore,
  });

  final bool isStore;

  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    // LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);
    // HomePageCubit homeCubit = HomePageCubit.get(context);
    return Expanded(
      flex: 3,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField(
                controller: null,
                width: null,
                hintText: S.of(context).search,
                onTap: (x) {},
                onChange: (x) {
                  billCubit.searchMethod(
                    letter: x,
                    originalList: billCubit.activeCategory,
                    isStore: isStore,
                  );
                },
              )
              // TextFormField(
              //   onTapOutside: (event) {
              //     FocusManager.instance.primaryFocus?.unfocus();
              //   },
              //   onChanged: (value) {
              //     billCubit.searchMethod(
              //       letter: value,
              //       originalList: billCubit.activeCategory,
              //     );
              //   },
              // ),
              ),
          Expanded(
            child: BlocBuilder<BillPageCubit, BillPageState>(
              builder: (context, state) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    billCubit.cardController
                        .add(TextEditingController(text: '1'));
                    billCubit.cardCounter.add(1);
                    return CardOfItemOrderFactory(
                      index: index,
                      isStore: isStore,
                    );
                  },
                  itemCount: (
                          // billCubit.
                          isStore)
                      ? billCubit.currentActiveCategory.length
                      : billCubit.currentActiveCategoryRaw.length,
                );
              },
            ),
          ),
        ],
      ),
      //  CardOfItem(),
    );
  }
}
