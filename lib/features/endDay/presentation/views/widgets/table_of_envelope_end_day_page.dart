import 'package:flutter/material.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/features/endDay/presentation/manager/cubit/end_day_page_cubit.dart';
import 'package:selling_point_app/features/endDay/presentation/views/widgets/data_row_of_table_of_envelope_end_day_page.dart';
import 'package:selling_point_app/features/home/presentation/manager/cubit/home_page_cubit.dart';

class TableOfEnvelopeEndDayPage extends StatelessWidget {
  const TableOfEnvelopeEndDayPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomePageCubit homeCubit = HomePageCubit.get(context);
    EndDayPageCubit endCubit = EndDayPageCubit.get(context);
    for (var i = 0; i < homeCubit.activeCategory.length; i++) {
      endCubit.invintoryController.add(TextEditingController());
      // endCubit.takenController.add(TextEditingController(text: '0'));
      // endCubit.soldController.add(TextEditingController(text: '0'));
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            // bottomLeft: Radius.circular(20),
            // bottomRight: Radius.circular(20),
          ),
          child: Container(
            color: AppColors.green1,
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return DataRowOfTableOfEnvelopeEndDayPage(
                        index: index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                    itemCount: homeCubit.activeCategory.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
