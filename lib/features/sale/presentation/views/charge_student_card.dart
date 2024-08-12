import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/custom_Loading_indicator.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/core/widgets/custom_error_widget.dart';
import 'package:selling_point_app/core/widgets/custom_left_side.dart';
import 'package:selling_point_app/core/widgets/custom_primary_bottom.dart';
import 'package:selling_point_app/core/widgets/custom_text.dart';
import 'package:selling_point_app/core/widgets/custom_text_form_field.dart';
import 'package:selling_point_app/features/sale/presentation/manager/cubit/sale_page_cubit.dart';
import 'package:selling_point_app/features/sale/presentation/views/widgets/dialog_of_charge_card.dart';
import 'package:selling_point_app/features/sale/presentation/views/widgets/left_recharge_side.dart';
import 'package:selling_point_app/generated/l10n.dart';

import '../../data/models/student_model.dart';

class ChargeStudentCard extends StatelessWidget {
  const ChargeStudentCard({super.key});

  @override
  Widget build(BuildContext context) {
    SalePageCubit saleCubit = SalePageCubit.get(context);

    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            const LeftRechargeSide(),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomPrimaryBottom(
                      name: '${S.of(context).scan} QR',
                      // ----- Click here to select a student ----
                      description: S.of(context).chargeScanBotton,
                      // -----------------------------------------
                      icon: Icons.charging_station_outlined,
                      onTap: () async {
                        await FlutterBarcodeScanner.scanBarcode(
                          '#ff6666',
                          'cancel',
                          true,
                          ScanMode.QR,
                        ).then((value) {
                          if (value == '-1') {
                            saleCubit.isChoosen = false;
                            // saleCubit.fetchOneStudent('1000042');
                          } else {
                            saleCubit.fetchOneStudent(value);
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      controller: saleCubit.chargeController,
                      // ---------- interAmount ---------
                      hintText: S.of(context).interAmount,
                      // --------------------------------
                      onTap: (x) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,6}'))
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const DialogOfChargeCard(),
                        );
                      },
                      child: Text(
                        // ----- charge ----
                        S.of(context).charge,
                        // -----------------
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
