import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/custom_Loading_indicator.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/core/widgets/custom_primary_bottom.dart';
import 'package:selling_point_app/features/endDay/presentation/manager/cubit/end_day_page_cubit.dart';

import '../../../../../core/widgets/custom_left_side.dart';
import '../../../../../generated/l10n.dart';
import '../../../../loginAndStart/presentation/manager/cubit/login_and_start_cubit.dart';
import 'end_day_page_body.dart';
import 'envelope_section.dart';
import 'package:intl/intl.dart';

class EnvelopePage extends StatelessWidget {
  const EnvelopePage({super.key});

  @override
  Widget build(BuildContext context) {
    EndDayPageCubit endCubit = EndDayPageCubit.get(context);
    LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          endCubit.envelopeAddress = TextEditingController();
          endCubit.envelopeAmount = TextEditingController(text: '0');
          return true;
        },
        child: Scaffold(
          body: Row(
            children: [
              CustomLeftSide(
                canReturn: true,
                // ------- EndDay Page ---------
                title: S.of(context).endDayTitle,
                // -----------------------------
                endDay: false,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const EnvelopeSection(),
                      const Divider(
                        endIndent: 60,
                        indent: 60,
                      ),
                      CustomPrimaryBottom(
                        name: 'ارسال بيانات الظرف',
                        description: 'يرجى ارسال بيانات الظرف قبل عملية الجرد',
                        icon: Icons.send,
                        onTap: () {
                          if (endCubit.formKay.currentState!.validate()) {
                            var body = {
                              "cash": endCubit.envelopeAmount.text,
                              "date": DateFormat('yyyy-MM-dd', 'en')
                                  .format(endCubit.dateFOrEnvelops),
                              "number": endCubit.envelopeAddress.text,
                            };
                            var data = {
                              "data": body,
                            };
                            print(
                                'sell point ID: ${loginCubit.sellPointInfo.data!.id}');
                            print(data);
                            endCubit.postEndEnvelops(
                              data,
                              loginCubit.sellPointInfo.data!.id!,
                            );
                          }
                        },
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     if (endCubit.formKay.currentState!.validate()) {
                      //       var body = {
                      //         "cash": endCubit.envelopeAmount.text,
                      //         "date": DateFormat('yyyy-MM-dd', 'en')
                      //             .format(endCubit.dateFOrEnvelops),
                      //         "number": endCubit.envelopeAddress.text,
                      //       };
                      //       var data = {
                      //         "data": body,
                      //       };
                      //       print(
                      //           'sell point ID: ${loginCubit.sellPointInfo.data!.id}');
                      //       print(data);
                      //       endCubit.postEndEnvelops(
                      //         data,
                      //         loginCubit.sellPointInfo.data!.id!,
                      //       );
                      //     }
                      //   },
                      //   child: Text(
                      //     S.of(context).post,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 50,
                      // ),
                      BlocConsumer<EndDayPageCubit, EndDayPageState>(
                        listener: (context, state) {
                          if (state is FailurePostEnvelopeState) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  state.errMessage,
                                  style: Styles.textStyle15DarkGreen,
                                ),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is LoadingPostEnvelopeState) {
                            return CustomLoadingIndicator(
                              color: AppColors.green1,
                            );
                          } else if (state is SuccessPostEnvelopeState) {
                            return Icon(
                              Icons.task_alt_rounded,
                              color: Colors.green,
                              size: 40,
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              // const Expanded(
              //   child: EnvelopeSection(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
