import 'package:flutter/material.dart';
import 'package:selling_point_app/core/widgets/custom_left_side.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/show_another_sp_order_page_body.dart';
import 'package:selling_point_app/generated/l10n.dart';

class ShowAnotherSpOrderPage extends StatelessWidget {
  const ShowAnotherSpOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            CustomLeftSide(
              canReturn: true,
              // ----- Show Another Sp Order Page --------
              title: S.of(context).showAnotherSpOrderTitle,
              // -----------------------------------------
              textAlign: TextAlign.center,
            ),
            const ShowAnotherSpOrderPageBody(),
          ],
        ),
      ),
    );
  }
}
