import 'package:flutter/material.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/styles.dart';
import '../../manager/cubit/sale_page_cubit.dart';

class TitleAndbackArrow extends StatelessWidget {
  const TitleAndbackArrow({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    SalePageCubit saleCubit = SalePageCubit.get(context);

    return Container(
      color: AppColors.green2,
      width: double.infinity,
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {
                    saleCubit.backToPrevious(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.green1,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                title,
                // textAlign: textAlign,
                style: Styles.textStyle18White,
              ),
            ),
          )
        ],
      ),
    );
  }
}
