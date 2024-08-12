import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/custom_Loading_indicator.dart';
import 'package:selling_point_app/core/widgets/custom_text.dart';
import 'package:selling_point_app/features/sale/presentation/manager/cubit/sale_page_cubit.dart';

import '../../../../generated/l10n.dart';

class UploadLocalData extends StatelessWidget {
  const UploadLocalData({super.key});

  @override
  Widget build(BuildContext context) {
    SalePageCubit saleCubit = SalePageCubit.get(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: BlocBuilder<SalePageCubit, SalePageState>(
            builder: (context, state) {
              if (state is SalePageInitial) {
                return CustomText(
                  // -- there is no local data to upload --
                  data: S.of(context).uploadPageMessage,
                  // --------------------------------------
                );
              } else if (state is LoadingFetchAllStudent) {
                return const CustomLoadingIndicator(
                  color: AppColors.green1,
                );
              } else if (state is FailureFetchAllStudentState) {
                return Column(
                  children: [
                    CustomText(data: state.errMessage),
                    IconButton(
                      icon: const Icon(
                        Icons.replay_outlined,
                        size: 80,
                      ),
                      onPressed: () {
                        Map<String, dynamic> offlineDataToSend = {
                          "students": saleCubit.students,
                          "orders": saleCubit.orders,
                        };
                        // print(offlineDataToSend);
                        saleCubit.postBillOffline(offlineDataToSend);
                      },
                    ),
                  ],
                );
              } else if (state is SuccessSaleFetchStudent) {
                return const Icon(
                  Icons.task_alt_rounded,
                  color: Colors.green,
                  size: 80,
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
