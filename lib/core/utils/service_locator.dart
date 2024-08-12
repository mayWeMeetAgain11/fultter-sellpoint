import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:selling_point_app/features/bills/data/repos/bills_repo_impl.dart';
import 'package:selling_point_app/features/endDay/data/repos/endDay_repo_impl.dart';
import 'package:selling_point_app/features/loginAndStart/data/repos/login_repo_impl.dart';
import 'package:selling_point_app/features/sale/data/repos/sale_repo_impl.dart';

import '../../features/home/data/repos/home_repo_impl.dart';
import 'api_service.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  // BaseOptions baseOptions = BaseOptions(
  //   baseUrl: ,
  //   connectTimeout: ,
  //   headers: ,
  //   receiveTimeout: ,
  //   sendTimeout: ,
  //   maxRedirects:  ,
  // );
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(),
    ),
  );
  getIt.registerSingleton<BillsRepoimpl>(
    BillsRepoimpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<LoginRepoimpl>(
    LoginRepoimpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<SaleRepoImpl>(
    SaleRepoImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<EndDayRepoImpl>(
    EndDayRepoImpl(getIt.get<ApiService>()),
  );
}
