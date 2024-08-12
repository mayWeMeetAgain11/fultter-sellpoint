import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:selling_point_app/core/errors/failures.dart';
import 'package:selling_point_app/core/utils/api_service.dart';
import 'package:selling_point_app/features/home/data/models/category_model.dart';
import 'package:selling_point_app/features/loginAndStart/data/models/login_model/login_model.dart';
import 'package:selling_point_app/features/loginAndStart/data/repos/login_repo.dart';

class LoginRepoimpl extends LoginRepo {
  final ApiService apiService;

  LoginRepoimpl(this.apiService);
  @override
  Future<Either<Failure, LoginModel>> postLoginSellPoint(
      Map<String, dynamic> data) async {
    try {
      print(data);
      var respone = await apiService.post(
        endPoint: 'sell-points/login',
        data: data,
        isLogin: true,
      );
      LoginModel loginData = LoginModel.fromJson(respone['data']);
      print('login repo impl success');
      return right(loginData);
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error');
      // print(e.toString());
      return left(ServerFailure(e.toString(), 700));
    }
  }

  // Future<Either<Failure, List<CategoryModel>>> getActiveCategory() async {
  //   try {
  //     var result = await apiService.get(
  //       endPoint: 'sell-points/category',
  //     );
  //     List<CategoryModel> activeCategory = [];
  //     for (var category in result['data']) {
  //       activeCategory.add(CategoryModel.fromJson(category));
  //     }
  //     return right(activeCategory);
  //   } catch (e) {
  //     if (e is DioException) {
  //       print('Dio Exception');
  //       return left(ServerFailure.fromDioError(e));
  //     }
  //     print('un expected error');
  //     return Left(ServerFailure(e.toString()));
  //   }
  // }
}
