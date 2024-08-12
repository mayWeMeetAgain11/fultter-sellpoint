import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:selling_point_app/core/errors/failures.dart';

import 'package:selling_point_app/features/home/data/models/category_model.dart';

import '../../../../core/utils/api_service.dart';
import 'home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<CategoryModel>>> getActiveCategory() async {
    try {
      var result = await apiService.get(
        endPoint: 'sell-points/category',
      );
      List<CategoryModel> activeCategory = [];
      for (var category in result['data']) {
        activeCategory.add(CategoryModel.fromJson(category));
      }
      return right(activeCategory);
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error');
      return left(ServerFailure(e.toString(), 700));
    }
  }

  @override
  Future<Either<Failure, bool>> checkForCAtegory() async {
    try {
      var result = await apiService.get(
        endPoint: 'sell-points/check-update',
      );
      return right(result['data']);
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error');
      return left(ServerFailure(e.toString(), 700));
    }
  }
}
