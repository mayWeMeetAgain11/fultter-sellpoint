import 'package:flutter/material.dart';
import 'package:selling_point_app/features/bills/presentation/views/widgets/custom_order_pages.dart';
import 'package:selling_point_app/generated/l10n.dart';

class OrderFromFactoryPage extends StatelessWidget {
  const OrderFromFactoryPage({
    super.key,
    required this.isStore,
    this.isReturn = true,
    this.isNew = false,
    this.isExternal = false,
  });
  final bool isStore;
  final bool isReturn;
  final bool isNew;
  final bool isExternal;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // -------------------- order from factory -----------------------
        body: CustomOrderPages(
          title: S.of(context).orderFromFactoryTitle,
          isStore: isStore,
          isNew: isNew,
          isReturn: isReturn,
          isExternal: isExternal,
        ),
        // ---------------------------------------------------------------
      ),
    );
  }
}

/*
Dismissible(
            key: Key('1'),
            child: Container(
              color: AppColors.black,
              height: 200,
              width: 200,
            ),
            onDismissed: (direction) {
              print('was deleted');
            },
          ),
        


 */
