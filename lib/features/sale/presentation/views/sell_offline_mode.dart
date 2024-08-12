import 'package:flutter/material.dart';
import 'package:selling_point_app/features/sale/presentation/views/widgets/custom_sale_page.dart';
import 'package:selling_point_app/generated/l10n.dart';


class SellOfflineMode extends StatelessWidget {
  const SellOfflineMode({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomSalePage(
          isOffline: true,
          // ----------- Offline ---------------
          title: S.of(context).saleBottomOffline,
          // -----------------------------------
        ),
      ),
    );
  }
}
