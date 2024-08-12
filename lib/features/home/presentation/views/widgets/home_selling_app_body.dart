import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:selling_point_app/core/widgets/custom_primary_bottom.dart';
import 'package:selling_point_app/features/bills/presentation/views/bills_home_page.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/manager/cubit/login_and_start_cubit.dart';
import 'package:selling_point_app/features/sale/presentation/views/sales_page.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../generated/l10n.dart';
import '../../../../endDay/presentation/views/end_day_page.dart';

class HomeSellingAppBody extends StatelessWidget {
  const HomeSellingAppBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // this bottom for sale page
              CustomPrimaryBottom(
                // ---------  sells  ---------------
                name: S.of(context).homeBottomSells,
                //----------------------------------
                icon: Icons.store,

                // -------------- sells your items -------------------
                description: S.of(context).homeBottomSellsDescription,
                //----------------------------------------------------
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SalesPage(),
                    ),
                  );
                  // loginCubit.getDataFromDatabase();
                },
              ),

              // this bottom for Bill page
              CustomPrimaryBottom(
                // ----------- bills --------------
                name: S.of(context).homeBottomBills,
                // --------------------------------
                icon: Icons.blinds_closed,
                // --------- order and show your bills --------------
                description: S.of(context).homeBottomBillsDescription,
                //---------------------------------------------------
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BillsPage(),
                    ),
                  );
                  // loginCubit.getDataFromDatabase();
                },
              ),
            ],
          ),
          // this bottom for EndDay page
          CustomPrimaryBottom(
            // ----------- End Day -------------
            name: S.of(context).homeBottomEndDay,
            // ---------------------------------
            icon: Icons.error_rounded,
            // -- enter the final amount and inventory your items --
            description: S.of(context).homeBottomEndDayDescription,
            // -----------------------------------------------------
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EndDayPage(),
                ),
              );
            },
          ),

          // CachedNetworkImage(
          //   imageUrl:
          //       // "https://articleify.com/wp-content/uploads/2020/09/Messi.jpg",
          //       // "https://timeengcom.com/shamseen/public/images/image_picker2963146881638978635.jpg",
          //       "https://timeengcom.com/shamseen/public/images/1693104184509-location_2981202.png",
          //   placeholder: (context, url) => SpinKitSpinningLines(
          //     size: 140,
          //     color: AppColors.green1,
          //   ),
          //   errorWidget: (context, url, error) => Icon(Icons.error),
          // ),
        ],
      ),
    );
  }
}
