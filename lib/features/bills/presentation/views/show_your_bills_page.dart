import 'package:flutter/material.dart';
import 'package:selling_point_app/core/widgets/custom_left_side.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/show_your_bills_page_body.dart';
import 'package:selling_point_app/generated/l10n.dart';

class ShowYourBillsPage extends StatelessWidget {
  const ShowYourBillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            CustomLeftSide(
              
              canReturn:
                  true, //this attribut for enable to show the return botton
              // ------- Show Your orders Page ------
              title: S.of(context).showYourBillsTitle,
              // ------------------------------------
              textAlign: TextAlign.center,
            ),
            const ShowYourBillsPageBody()
          ],
        ),
      ),
    );
  }
}
