import 'package:flutter/material.dart';
import 'package:selling_point_app/constants.dart';
import 'package:selling_point_app/core/cache/cashe_helper.dart';
import 'package:selling_point_app/core/widgets/custom_primary_bottom.dart';
import 'package:selling_point_app/features/sale/presentation/manager/cubit/sale_page_cubit.dart';
import 'package:selling_point_app/features/sale/presentation/views/sell_offline_mode.dart';
import 'package:selling_point_app/features/sale/presentation/views/sell_online_mode.dart';
import 'package:selling_point_app/features/sale/presentation/views/upload_local_data.dart';
import 'package:selling_point_app/generated/l10n.dart';

import '../../../data/models/student_model.dart';
import '../charge_student_card.dart';

class SalesPageBody extends StatelessWidget {
  const SalesPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SalePageCubit saleCubit = SalePageCubit.get(context);
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spa,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // this bottom for Online sale
                CustomPrimaryBottom(
                  // ------------- Online ------------
                  name: S.of(context).saleBottomOnline,
                  // ---------------------------------
                  icon: Icons.store,
                  // --------- must exist the internet -----------------
                  description: S.of(context).saleBottomOnlineDescription,
                  // ---------------------------------------------------
                  onTap: () async {
                    await saleCubit
                        .getAllOrdersFromDatabase(saleCubit.database2);
                    await saleCubit
                        .getAllStudentFromDatabase(saleCubit.database2);
                    if (saleCubit.orders.length > 0 &&
                        saleCubit.students.length > 0) {
                      print('oeder ${saleCubit.orders.length}');
                      print('student ${saleCubit.students.length}');
                      // print(saleCubit.orders.length);
                      // print(saleCubit.students.length);
                      print('55555555555555555555555555555');
                      Map<String, dynamic> offlineDataToSend = {
                        "students": saleCubit.students,
                        "orders": saleCubit.orders,
                      };
                      // print(offlineDataToSend);
                      saleCubit.postBillOffline(offlineDataToSend);
                    } else {
                      CasheHelper.setData(
                          key: Constants.kfetchedStudent, value: false);

                      await saleCubit
                          .deleteStudentsAndOrdersTablesFromDatabase();
                      print(saleCubit.students.length);
                      saleCubit.interToSalePages();
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SellOnlineMode(),
                      ),
                    );
                  },
                ),

                // this bottom for Offline sale
                CustomPrimaryBottom(
                  // ------------- Offline ------------
                  name: S.of(context).saleBottomOffline,
                  // ----------------------------------
                  icon: Icons.store,
                  // -- the first step need internet, then sell offline --
                  description: S.of(context).saleBottomOfflineDescription,
                  // -----------------------------------------------------
                  onTap: () {
                    saleCubit.interToSalePages();
                    /* 
                        the key 'kfetchedStudent' was initial in 
                        casheInit methods by false 
                     */
                    if (!CasheHelper.getData(key: Constants.kfetchedStudent)) {
                      saleCubit.fetchAllStudens();
                    }

                    // print(saleCubit.getStudentFromDatabase(
                    // saleCubit.database2, '1000042'));

                    // saleCubit.deleteStudentsTableFromDatabase();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SellOfflineMode(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // this bottom for upload local data
                CustomPrimaryBottom(
                  // ------ 'Upload locally data' -----
                  name: S.of(context).uploadBottonTitle,
                  // ----------------------------------
                  description: S.of(context).uploadBottonDescription,
                  icon: Icons.post_add_rounded,
                  onTap: () async {
                    await saleCubit
                        .getAllOrdersFromDatabase(saleCubit.database2);
                    await saleCubit
                        .getAllStudentFromDatabase(saleCubit.database2);
                    if (saleCubit.orders.length > 0 &&
                        saleCubit.students.length > 0) {
                      print('oeder ${saleCubit.orders.length}');
                      print('student ${saleCubit.students.length}');
                      // print(saleCubit.orders.length);
                      // print(saleCubit.students.length);
                      print('55555555555555555555555555555');
                      Map<String, dynamic> offlineDataToSend = {
                        "students": saleCubit.students,
                        "orders": saleCubit.orders,
                      };
                      // print(offlineDataToSend);
                      saleCubit.postBillOffline(offlineDataToSend);
                    } else {
                      saleCubit.interToSalePages();
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const UploadLocalData(),
                      ),
                    );
                  },
                ),
                // this bottom for Recharge card
                CustomPrimaryBottom(
                  // ---- Recharge student cards --------
                  name: S.of(context).rechargeStudentCards,
                  // ------------------------------------
                  // --------- Recharge by QR -----------
                  description: S.of(context).RechargeByQR,
                  // ------------------------------------
                  icon: Icons.qr_code_2,
                  onTap: () {
                    saleCubit.student =
                        StudentModel(balance: 0.0, threshold: 0.0);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChargeStudentCard(),
                    ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
