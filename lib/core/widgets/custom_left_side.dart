import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_point_app/constants.dart';
import 'package:selling_point_app/core/cache/cashe_helper.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/custom_Loading_indicator.dart';
import 'package:selling_point_app/core/utils/styles.dart';
import 'package:selling_point_app/core/widgets/custom_error_widget.dart';
import 'package:selling_point_app/core/widgets/custom_text.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:selling_point_app/features/endDay/presentation/manager/cubit/end_day_page_cubit.dart';
import 'package:selling_point_app/features/home/presentation/manager/cubit/home_page_cubit.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/manager/cubit/login_and_start_cubit.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/views/login_page.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/views/start_page.dart';
import 'package:selling_point_app/features/sale/presentation/manager/cubit/sale_page_cubit.dart';
import 'package:selling_point_app/generated/l10n.dart';

// import 'package:intl/intl.dart'
class CustomLeftSide extends StatelessWidget {
  const CustomLeftSide({
    super.key,
    this.canReturn = false,
    required this.title,
    this.endDay = false,
    this.textAlign,
    this.isHome = false,
    this.isBillsHome = false,
    this.typeOfExpenses = 'none',
  });
  final bool canReturn;
  final String title;
  final bool endDay;
  final bool isHome;
  final bool isBillsHome;
  final TextAlign? textAlign;
  final String typeOfExpenses;

  @override
  Widget build(BuildContext context) {
    LoginAndStartCubit loginCubit = LoginAndStartCubit.get(context);
    BillPageCubit billCubit = BillPageCubit.get(context);
    EndDayPageCubit endCubit = EndDayPageCubit.get(context);
    SalePageCubit saleCubit = SalePageCubit.get(context);
    HomePageCubit homeCubit = HomePageCubit.get(context);
    GlobalKey<FormState> formKay = endCubit.formKay;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(20),
              bottomEnd: Radius.circular(20),
            ),
            child: Container(
              color: AppColors.green1,
              width: width * .25,
              height: height,
              child: Column(
                children: [
                  Container(
                    color: AppColors.green2,
                    width: double.infinity,
                    height: height * .15,
                    child: Row(
                      children: [
                        if (isHome)
                          BlocBuilder<HomePageCubit, HomePageState>(
                            builder: (context, state) {
                              if (state is! LoadingfetchActiveCatState) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 20),
                                      child: PopupMenuButton(
                                        child: const Icon(
                                          Icons.dashboard_customize_rounded,
                                          color: AppColors.white,
                                        ),
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                            value: 'en',
                                            child: Text('English'),
                                          ),
                                          const PopupMenuItem(
                                            value: 'ar',
                                            child: Text('العربية'),
                                          ),
                                        ],
                                        onSelected: (value) async {
                                          if (value == 'ar') {
                                            var res = await CasheHelper.getData(
                                              key: Constants.klangSympol,
                                            );
                                            if (res != 'ar') {
                                              await loginCubit.setLang(
                                                  Constants.klangSympol, 'ar');
                                              print('change to ar');
                                            }
                                          } else if (value == 'en') {
                                            var res = await CasheHelper.getData(
                                                key: Constants.klangSympol);
                                            if (res != 'en') {
                                              await loginCubit.setLang(
                                                  Constants.klangSympol, 'en');
                                              print('change to en');
                                            }
                                          }
                                          print(CasheHelper.getData(
                                              key: Constants.klangSympol));
                                          print(value);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 20),
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Text(
                                                S.of(context).exit,
                                                style:
                                                    Styles.textStyle15DarkGreen,
                                              ),
                                              actionsAlignment:
                                                  MainAxisAlignment.start,
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    CasheHelper.setData(
                                                      key: Constants.kfirstTime,
                                                      value: true,
                                                    );
                                                    CasheHelper.deleteData(
                                                      key: Constants.ktoken,
                                                    );
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginPage(),
                                                      ),
                                                      (route) => false,
                                                    );
                                                  },
                                                  child: Text(
                                                    S.of(context).ok,
                                                    style: Styles
                                                        .textStyle15DarkGreen,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                  ),
                                                  child: Text(
                                                    S.of(context).cancel,
                                                    style:
                                                        Styles.textStyle15White,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.exit_to_app,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          )
                        else
                          const SizedBox(),
                        if (canReturn)
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (isBillsHome) {
                                      billCubit.billReturnMethod(context);
                                    } else {
                                      Navigator.pop(context);
                                      billCubit.detailsOfSpBill = {};
                                      endCubit.envelopeAddress =
                                          TextEditingController();
                                      endCubit.envelopeAmount =
                                          TextEditingController(text: '0');
                                      endCubit.dateFOrInventory =
                                          DateTime.now();
                                      billCubit.detailsOfFActoryBill = {};
                                      endCubit.invintoryController.clear();
                                    }
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: AppColors.green1,
                                  ),
                                ),
                                // IconButton(
                                //   onPressed: () {},
                                //   color: AppColors.white,
                                //   icon: Icon(
                                //     Icons.arrow_back,
                                //   ),
                                // ),
                              ),
                            ),
                          )
                        else
                          const Expanded(child: SizedBox()),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              title,
                              maxLines: 2,
                              textAlign: textAlign,
                              style: Styles.textStyle18White,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/image/shamseen.png'),
                          radius: 80,
                          backgroundColor: AppColors.white,
                          // child: Image(
                          //   image: AssetImage('assets/image/shamseen.png'),
                          //   fit: BoxFit.cover,
                          // )
                          //  Icon(
                          //   Icons.person_outline,
                          //   color: AppColors.green1,
                          //   size: 40,
                          // ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          loginCubit.sellPointInfo.data!.name!,
                          style: Styles.textStyle20White,
                          // TextStyle(
                          //   fontSize: 20,
                          //   fontWeight: FontWeight.bold,
                          //   color: AppColors.white,
                          // ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          // ---- Sell piont Account -----
                          S.of(context).MainTitle,
                          // ----------------------------
                          style: Styles.textStyle14,
                          // TextStyle(
                          //   fontSize: 15,
                          //   color: AppColors.white.withOpacity(.6),
                          // ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                            indent: 20,
                            endIndent: 20,
                            color: Color.fromARGB(182, 255, 255, 255)),
                      ],
                    ),
                  ),
                  if (endDay)
                    BlocConsumer<EndDayPageCubit, EndDayPageState>(
                      listener: (context, state) {
                        if (state is SuccessPostInvintory) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white),
                                child: const Icon(
                                  Icons.task_alt_rounded,
                                  color: Colors.green,
                                  size: 80,
                                ),
                              ),
                            ),
                          );
                          // endCubit.invintoryController.clear();
                          // endCubit.invintoryController = [];
                          // // endCubit.takenController = [];
                          // endCubit.invintoryController = [];
                          // endCubit.envelopeAddress.clear();
                          // endCubit.envelopeAmount.clear();
                          // saleCubit.deleteStudentsAndOrdersTablesFromDatabase();
                          // CasheHelper.setData(
                          //     key: Constants.kfirstOrderFActory, value: false);
                          // CasheHelper.setData(
                          //     key: Constants.kfirstOrderSp, value: false);
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const StartPage(),
                          //   ),
                          //   (route) => false,
                          // );
                        } else if (state is FailureEndDayState) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                state.errMessage,
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is LoadingEndDayState) {
                          return const CustomLoadingIndicator();
                        }
                        //  else if (state is FailureEndDayState) {
                        // return CustomErrorWidget(
                        // errMessage: state.errMessage);
                        // }
                        // else if (state is SuccessPostInvintory) {
                        //   return Container(
                        //     decoration: const BoxDecoration(
                        //         shape: BoxShape.circle, color: AppColors.white),
                        //     child: const Icon(
                        //       Icons.task_alt_rounded,
                        //       color: Colors.green,
                        //       size: 80,
                        //     ),
                        //   );
                        // }
                        else {
                          return const SizedBox();
                        }
                      },
                    ),
                  if (endDay)
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: 120,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              // if (formKay.currentState!.validate()) {

                              await saleCubit.getAllOrdersFromDatabase(
                                  saleCubit.database2);
                              await saleCubit.getAllStudentFromDatabase(
                                  saleCubit.database2);
                              if (saleCubit.orders.length > 0 &&
                                  saleCubit.students.length > 0 &&
                                  typeOfExpenses == ' none') {
                                print('oeder ${saleCubit.orders.length}');
                                print('student ${saleCubit.students.length}');

                                // ignore: use_build_context_synchronously
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Row(
                                      children: [
                                        CustomText(
                                          // -- There is local data, upload it to the server and then inventory the items --
                                          data: S.of(context).endDayDialog,
                                          // -------------------------------------------------------------------------------
                                        ),
                                        const Icon(
                                          Icons.error_outline,
                                          color: AppColors.red,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          S.of(context).ok,
                                          style: Styles.textStyle18,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // double cash = double.parse(
                                //     endCubit.envelopeAmount.text);
                                // double spExpenses =
                                //     double.parse(endCubit.takenAmount.text);
                                Map<String, dynamic> data = {
                                  // "number": endCubit.envelopeAddress.text,
                                  // "cash": cash,
                                  "date": DateFormat('yyyy-MM-dd', 'en').format(
                                    endCubit.dateFOrInventory,
                                  ),
                                  // "sp_expenses": spExpenses
                                };
                                List<Map<String, int>> billsBOdy = [];
                                // must edit here
                                print(endCubit.invintoryController.length);
                                for (int i = 0;
                                    i < endCubit.invintoryController.length;
                                    i++) {
                                  int? amount = int.tryParse(
                                      endCubit.invintoryController[i].text);
                                  // int spExpenses = int.parse(
                                  //     endCubit.takenController[i].text);
                                  // int? amount = int.tryParse(
                                  //     endCubit.invintoryController[i].text);
                                  if (amount != null) {
                                    billsBOdy.add({
                                      "category_id":
                                          homeCubit.activeCategory[i].id!,
                                      "amount": amount,
                                      // "sp_expenses": spExpenses
                                    });
                                  }
                                }
                                data['date'] = DateFormat('yyyy-MM-dd', 'en')
                                    .format(endCubit.dateFOrInventory);
                                data['bills'] = billsBOdy;
                                // print(billsBOdy);
                                print(data);
                                CasheHelper.setData(
                                  key: Constants.kfetchedStudent,
                                  value: false,
                                );
                                if (billsBOdy.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                      title: Text(
                                        'الرجاء ادخال جرد لعنصر واحد على الاقل',
                                        style: Styles.textStyle15DarkGreen,
                                      ),
                                    ),
                                  );
                                } else if (typeOfExpenses != 'none') {
                                  if (typeOfExpenses == 'doctor') {
                                    data['type'] = 'expens_doctor';
                                  } else if (typeOfExpenses == 'manager') {
                                    data['type'] = 'expens_manager';
                                  } else if (typeOfExpenses == 'default') {
                                    data['type'] = 'expenses';
                                  } else if (typeOfExpenses == 'returns') {
                                    data['type'] = 'returns';
                                  } else {
                                    // ! this for expens_eco حالات اقتصادية
                                    data['type'] = typeOfExpenses;
                                  }
                                  billCubit.postBillToFActory(data);
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      scrollable: true,
                                      content: BlocBuilder<BillPageCubit,
                                          BillPageState>(
                                        builder: (context, state) {
                                          if (state
                                              is LoadingPostToFactoryBillState) {
                                            return CustomLoadingIndicator(
                                              color: AppColors.green1,
                                            );
                                          } else if (state is FailurePostData) {
                                            return CustomErrorWidget(
                                              errMessage: state.errMessage,
                                              iconColor: Colors.red,
                                              textStyle: Styles.textStyle20White
                                                  .copyWith(color: Colors.red),
                                            );
                                          } else if (state is SuccessPostBill) {
                                            return ListTile(
                                              title: Text(
                                                'تم الارسال بنجاح',
                                                style:
                                                    Styles.textStyle17DarkGreen,
                                              ),
                                              trailing: Icon(
                                                Icons.task_rounded,
                                                color: Colors.green,
                                              ),
                                            );
                                          } else {
                                            return SizedBox();
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  // if (CasheHelper.getData(
                                  //     key: Constants.kIsEnvelopeDone))
                                  {
                                    if (kDebugMode) {
                                      print('we are in End Inventory');
                                      print(data);
                                    }
                                    await saleCubit
                                        .deleteStudentsAndOrdersTablesFromDatabase();
                                    endCubit.postEndInvintory(data);
                                  }
                                  // else {
                                  //   showDialog(
                                  //     context: context,
                                  //     builder: (context) => const AlertDialog(
                                  //       title: Text(
                                  //         'الرجاء ادخال معلومات الظرف في المكان المخصص لذلك',
                                  //         style: Styles.textStyle15DarkGreen,
                                  //       ),
                                  //     ),
                                  //   );
                                  // }
                                }
                              }
                              // }
                            },
                            child: Text(
                              S.of(context).post,
                              style: Styles.textStyle15DarkGreen,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
