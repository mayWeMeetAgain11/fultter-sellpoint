import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:selling_point_app/constants.dart';
import 'package:selling_point_app/core/cache/cashe_helper.dart';
import 'package:selling_point_app/core/utils/app_color.dart';
import 'package:selling_point_app/core/utils/bloc_observer.dart';
import 'package:selling_point_app/features/bills/data/repos/bills_repo_impl.dart';
import 'package:selling_point_app/features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:selling_point_app/features/endDay/presentation/manager/cubit/end_day_page_cubit.dart';
import 'package:selling_point_app/features/home/presentation/manager/cubit/home_page_cubit.dart';
import 'package:selling_point_app/features/loginAndStart/data/repos/login_repo_impl.dart';
import 'package:selling_point_app/features/loginAndStart/presentation/manager/cubit/login_and_start_cubit.dart';
import 'package:selling_point_app/features/sale/presentation/manager/cubit/sale_page_cubit.dart';
import 'package:selling_point_app/generated/l10n.dart';
import 'package:selling_point_app/responsive/home_page.dart';
import 'core/utils/service_locator.dart';
import 'features/endDay/data/repos/endDay_repo_impl.dart';
import 'features/home/data/repos/home_repo_impl.dart';
import 'features/sale/data/repos/sale_repo_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  await CasheHelper.casheInit(Constants.klangSympol);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              HomePageCubit(getIt.get<HomeRepoImpl>())..createDataBase(),
        ),
        BlocProvider(
          create: (context) => LoginAndStartCubit(getIt.get<LoginRepoimpl>()),
        ),
        BlocProvider(
          create: (context) => BillPageCubit(getIt.get<BillsRepoimpl>()),
        ),
        BlocProvider(
          create: (context) =>
              SalePageCubit(getIt.get<SaleRepoImpl>())..createDataBase(),
        ),
        BlocProvider(
          create: (context) => EndDayPageCubit(getIt.get<EndDayRepoImpl>()),
        ),
      ],
      child: BlocBuilder<LoginAndStartCubit, LoginAndStartState>(
        builder: (context, state) {
          print('here our bloc');
          return MaterialApp(
            locale: Locale(CasheHelper.getData(key: Constants.klangSympol)),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            // locale: Locale('ar'),
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green1),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            // home: const StartPage(),
            // home: const LoginPage(),

            home: const HomePage(),

            // home: const SplashView(),

            // home: const MobileBody(),
            // home: const MobileBody(),
            // home: const ChargeStudentCard(),
            // home: const MyHomePage(),
            // home: const SalesPage(),
            // home: const BillsPage(),
          );
        },
      ),
    );
  }
}
