import 'package:flutter/material.dart';
import 'package:selling_point_app/core/widgets/custom_left_side.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/bills_home_page_body.dart';
import 'package:selling_point_app/generated/l10n.dart';

class BillsPage extends StatelessWidget {
  const BillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    // LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);

    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            // ------------------------ bills page ----------------------------
            CustomLeftSide(
                canReturn: true,
                title: S.of(context).billPageTitle,
                isBillsHome: true),
            // ----------------------------------------------------------------
            // const BillsHomePageBody(),
            const BillsHomePageBody(),
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

            //       return const BillsHomePageBody();
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
