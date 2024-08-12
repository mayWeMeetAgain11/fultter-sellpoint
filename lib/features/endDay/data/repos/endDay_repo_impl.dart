import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:selling_point_app/core/errors/failures.dart';
import 'package:selling_point_app/features/endDay/data/repos/endDay_repo.dart';

import '../../../../core/utils/api_service.dart';

class EndDayRepoImpl extends EndDayRepo {
  final ApiService apiService;

  EndDayRepoImpl(this.apiService);

  @override
  Future<Either<Failure, String>> postInvintory(
      Map<String, dynamic> data) async {
    try {
      var respone = await apiService.post(
          endPoint: 'sell-points/bills/inventory', data: data);
      return right('Success');
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        print(e.type);
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error');
      return left(ServerFailure(e.toString(), 700));
    }
  }

  @override
  Future<Either<Failure, String>> postEnvelope(
      Map<String, dynamic> data, int sellPointID) async {
    try {
      var respone = await apiService.post(
          endPoint: 'sell-points/envelop/add/$sellPointID', data: data);
      return right('Success');
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        print(e.type);
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error');
      return left(ServerFailure(e.toString(), 700));
    }
  }

  @override
  Future<Either<Failure, String>> postExpensesToFactory(
      Map<String, dynamic> data) async {
    try {
      var response = await apiService.post(
        endPoint: 'sell-points/bills/factory',
        data: data,
      );
      return right('Success');
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        print(e.type);
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error');
      return left(ServerFailure(e.toString(), 700));
    }
  }
}
