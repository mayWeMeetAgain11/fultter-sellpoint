import 'package:flutter/material.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/custom_order_pages.dart';
import 'package:selling_point_app/generated/l10n.dart';

class OrderFromSpPage extends StatelessWidget {
  const OrderFromSpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomOrderPages(
          fromSp: true,
          // ---------- order from SP ---------
          title: S.of(context).orderFromSpTitle,
          // ----------------------------------
          isStore: true, // this attribute Useless
        ),
      ),
    );
  }
}
