import 'package:flutter/material.dart';
import 'package:selling_point_app/features/sale/presentation/views/widgets/custom_sale_page.dart';

import '../../../../generated/l10n.dart';

class SellOnlineMode extends StatelessWidget {
  const SellOnlineMode({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomSalePage(
          // ----------- online ---------------
          title: S.of(context).saleBottomOnline,
          // ----------------------------------
        ),
      ),
    );
  }
}
