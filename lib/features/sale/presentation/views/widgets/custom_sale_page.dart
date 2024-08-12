import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/features/sale/presentation/manager/cubit/sale_page_cubit.dart';
import 'package:selling_point_app/features/sale/presentation/views/widgets/custom_sale_page_body.dart';
import 'package:selling_point_app/features/sale/presentation/views/widgets/left_side_of_sale_page.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/custom_Loading_indicator.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../generated/l10n.dart';

class CustomSalePage extends StatelessWidget {
  const CustomSalePage({
    super.key,
    this.isOffline = false,
    required this.title,
  });
  final bool isOffline;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // --------------------- offline - offline -------------------------
        LeftSideOfSalePage(
          title: title,
          isOffline: isOffline,
        ),
        // ------------------------------------------------------
        BlocBuilder<SalePageCubit, SalePageState>(
          builder: (context, state) {
            if (state is LoadingFetchAllStudent) {
              return const Expanded(
                child: CustomLoadingIndicator(
                  color: AppColors.green1,
                ),
              );
            }
            if (state is FailureFetchAllStudentState) {
              return CustomErrorWidget(errMessage: state.errMessage);
            } else {
              return const CustomSalePageBody();
            }
          },
        ),
      ],
    );
  }
}
