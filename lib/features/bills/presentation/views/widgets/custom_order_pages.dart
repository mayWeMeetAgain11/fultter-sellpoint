import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/custom_Loading_indicator.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/core/widgets/custom_error_widget.dart';
import 'package:selling_point_app/core/widgets/custom_text.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/custom_order_pages_body.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/left_side_of_order_pages.dart';

import '../../../../../generated/l10n.dart';
import 'custom_order_pages_body_factory.dart';

class CustomOrderPages extends StatelessWidget {
  const CustomOrderPages({
    super.key,
    this.fromSp = false,
    required this.title,
    required this.isStore,
    this.isReturn = true,
    this.isNew = false,
    this.isExternal = false,
  });
  final bool? fromSp;
  final String title;
  final bool isStore;
  final bool isReturn;
  final bool isNew;
  final bool isExternal;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    BillPageCubit billCubit = BillPageCubit.get(context);
    return Row(
      children: [
        LeftSideOfOrderPages(
          title: title,
          toSp: fromSp,
          isStore: isStore,
          isNew: isNew,
          isReturn: isReturn,
          isExternal: isExternal,
        ),
        if (!fromSp!)
          BlocBuilder<BillPageCubit, BillPageState>(
            builder: (context, state) {
              if (state is LoadingActiveCategoryState) {
                return const Expanded(
                  child: CustomLoadingIndicator(
                    color: AppColors.green1,
                  ),
                );
              } else if (state is FailureActivecategoryState) {
                return Expanded(
                  child: CustomErrorWidget(
                    errMessage: state.errMessage,
                    iconColor: AppColors.darkGreen1,
                    textStyle: Styles.textStyle23DarkGreen,
                  ),
                );
              } else if (billCubit.activeCategory.length == 0 && isStore) {
                return Expanded(
                  child: Center(
                    child: CustomText(
                      // ----- there Is No Data ---------
                      data: S.of(context).thereIsNoData,
                      // -----------------------------
                    ),
                  ),
                );
              } else if (billCubit.activeCategoryRaw.length == 0 && !isStore) {
                return Expanded(
                  child: Center(
                    child: CustomText(
                      // ----- there Is No Data ---------
                      data: S.of(context).thereIsNoData,
                      // -----------------------------
                    ),
                  ),
                );
              } else {
                return CustomOrderPagesBodyFactory(
                  isStore: isStore,
                );
              }
            },
          )
        else
          const CustomOrderPagesBody(),
      ],
    );
  }
}
