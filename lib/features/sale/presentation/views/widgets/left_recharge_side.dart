import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/custom_Loading_indicator.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../data/models/student_model.dart';
import '../../manager/cubit/sale_page_cubit.dart';

class LeftRechargeSide extends StatelessWidget {
  const LeftRechargeSide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SalePageCubit saleCubit = SalePageCubit.get(context);
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadiusDirectional.only(
          topEnd: Radius.circular(30),
          bottomEnd: Radius.circular(30),
        ),
        child: Container(
          color: AppColors.green1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    saleCubit.emit(SalePageInitial());
                    saleCubit.student =
                        StudentModel(balance: 0.0, threshold: 0.0);
                    saleCubit.chargeController.clear();
                    bool isChoosen = false;
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.green1,
                  ),
                ),
              ),
              BlocBuilder<SalePageCubit, SalePageState>(
                builder: (context, state) {
                  if (state is LoadingSaleFetchStudentState) {
                    return const CustomLoadingIndicator();
                  } else {
                    if (saleCubit.student.id == null) {
                      return const SizedBox();
                    } else {
                      return Column(
                        children: [
                          CustomText(
                            data:
                                'student name : ${saleCubit.student.firstName} ${saleCubit.student.midName} ${saleCubit.student.lastName}',
                          ),
                          CustomText(
                              data: 'balance : ${saleCubit.student.balance}'),
                        ],
                      );
                    }
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<SalePageCubit, SalePageState>(
                builder: (context, state) {
                  if (state is LoadingCardCharge) {
                    return const CustomLoadingIndicator();
                  } else if (state is SuccessCardCharge) {
                    return const Icon(
                      Icons.done_all,
                      color: Colors.green,
                      size: 80,
                    );
                  } else if (state is FailureCardCharge) {
                    return CustomErrorWidget(errMessage: state.errMessage);
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}