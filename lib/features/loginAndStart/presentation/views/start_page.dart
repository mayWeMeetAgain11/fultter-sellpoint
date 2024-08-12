import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:selling_point_app/constants.dart';
import 'package:selling_point_app/core/cache/cashe_helper.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/widgets/custom_left_side.dart';
import 'package:selling_point_app/core/widgets/custom_primary_bottom.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:selling_point_app/features/home/presentation/manager/cubit/home_page_cubit.dart';
import 'package:selling_point_app/features/home/presentation/views/home_app_page.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/manager/cubit/login_and_start_cubit.dart';
import 'package:selling_point_app/features/sale/presentation/manager/cubit/sale_page_cubit.dart';
import '../../../../generated/l10n.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);
    HomePageCubit homeCubit = HomePageCubit.get(context);
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
// https://i1.wp.com/www.thesun.co.uk/wp-content/uploads/2017/02/nintchdbpict000301894696.jpg?ssl=1
// https://s.yimg.com/uu/api/res/1.2/nj6w8mbFrQFBm_tQiX_F0w--~B/aD0yNjQ3O3c9MzczNztzbT0xO2FwcGlkPXl0YWNoeW9u/https://img.huffingtonpost.com/asset/5cb62e40230000c2006db3ac.jpeg
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            CustomLeftSide(
              title: S.of(context).startDayTitle,
            ),
            Expanded(
              child: Center(
                child: CustomPrimaryBottom(
                  // ----------- Start Page -------
                  name: S.of(context).startDayTitle,
                  //-------------------------------
                  icon: Icons.store,
                  // ---------start our step -------------------
                  description: S.of(context).startDayDescription,
                  //--------------------------------------------
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(),
                      ),
                      (route) => false,
                    );
                    // print(CasheHelper.getData(key: Constants.ktoken));
                    // homeCubit.fetchActiveCategory();
                    if (CasheHelper.getData(key: Constants.kfirstTime)) {
                      homeCubit.fetchActiveCategory();
                    } else {
                      homeCubit.fetchActiveCategory();

                      // homeCubit.checkForUpdateCAtegory();
                    }
                  },
                ),
              ),
            ),
            // cashed network Example

            // SizedBox(
            //   height: 200,
            //   width: 200,
            //   child: CachedNetworkImage(
            //     imageUrl:
            //         // "https://th.bing.com/th/id/R.d4905e2994199198de6f39df0ba25947?rik=psb0ZLiS3%2bPSQA&riu=http%3a%2f%2fthewowstyle.com%2fwp-content%2fuploads%2f2015%2f01%2fLionel-Messi-Photos.jpg&ehk=6MvbpO2DO8866ptJbXJ4I0Nod4NMXTksoZORo4G1iVk%3d&risl=&pid=ImgRaw&r=0",
            //         "https://s.yimg.com/uu/api/res/1.2/nj6w8mbFrQFBm_tQiX_F0w--~B/aD0yNjQ3O3c9MzczNztzbT0xO2FwcGlkPXl0YWNoeW9u/https://img.huffingtonpost.com/asset/5cb62e40230000c2006db3ac.jpeg",
            //         // "https://i1.wp.com/www.thesun.co.uk/wp-content/uploads/2017/02/nintchdbpict000301894696.jpg?ssl=1",
            //     placeholder: (context, url) => SpinKitSpinningLines(
            //       size: 140,
            //       color: AppColors.green1,
            //     ),
            //     errorWidget: (context, url, error) => Icon(Icons.error),
            //   ),
            // ),

            // Text(
            //   "height $height     ",
            // ),
            // Text(
            //   "width $width     ",
            // ),
          ],
        ),
      ),
    );
  }
}
