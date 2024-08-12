import 'package:flutter/material.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../generated/l10n.dart';

class CustomSaleDialog extends StatelessWidget {
  const CustomSaleDialog({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          CustomText(
            data: text,
          ),
          const Icon(
            Icons.error_outline,
            color: AppColors.red,
          ),
        ],
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(S.of(context).ok),
          ),
        ),
      ],
    );
  }
}
