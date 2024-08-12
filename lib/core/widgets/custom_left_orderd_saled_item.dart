import 'package:flutter/material.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/generated/l10n.dart';

class CustomLeftOrderdSaledItem extends StatelessWidget {
  const CustomLeftOrderdSaledItem({
    super.key,
    required this.index,
    required this.itemName,
    required this.quantity,
    required this.price,
  });
  final int index;
  final String itemName;
  final double price;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: AppColors.white,
        shadowColor: const Color.fromARGB(89, 197, 191, 191),
        elevation: 10,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // 'datsdffffffffffffffsfffffffs',
                        // ourCubit.l[index]['eName'],
                        itemName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.textStyle15SB,
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // 'price \n  ${ourCubit.l[index]['tPrice']}',
                      S.of(context).orderFromFactoryPrice,
                      style: Styles.textStyle15SB,
                    ),
                    Text(
                      // 'price \n  ${ourCubit.l[index]['tPrice']}',
                      price.toString(),
                      style: Styles.textStyle15SB,
                    ),
                  ],
                ),
                const VerticalDivider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).orderFromFactoryQuantity,
                      style: Styles.textStyle15SB,
                    ),
                    Text(
                      quantity.toString(),
                      style: Styles.textStyle15SB,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
