import 'package:flutter/material.dart';
import 'package:selling_point_app/core/widgets/custom_left_side.dart';
import 'package:selling_point_app/features/sale/presentation/views/widgets/sales_page_body.dart';

import '../../../../generated/l10n.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);

    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            CustomLeftSide(
              canReturn: true,
              // ----------- Sales Page --------
              title: S.of(context).salePageTitle,
              // ---------------------------------
            ),
            const SalesPageBody(),
            // BlocBuilder<LoginAndStartCubit, LoginAndStartState>(
            //   builder: (context, state) {
            //     if (state is AppGetDatabaseLoadingState) {
            //       return const Expanded(
            //         child: CustomLoadingIndicator(
            //           color: AppColors.green1,
            //         ),
            //       );
            //     } else if (state is AppFailureGetDatabaseState) {
            //       return Expanded(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             const SizedBox(
            //               height: 30,
            //             ),
            //             IconButton(
            //               onPressed: () {
            //                 loginCubit.getDataFromDatabase();
            //               },
            //               icon: const Icon(
            //                 Icons.replay_outlined,
            //                 color: AppColors.green1,
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     } else {
            //       return const SalesPageBody();
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
