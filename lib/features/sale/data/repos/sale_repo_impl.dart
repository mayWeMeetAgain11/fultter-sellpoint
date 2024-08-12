import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:selling_point_app/core/errors/failures.dart';
import 'package:selling_point_app/core/utils/api_service.dart';
import 'package:selling_point_app/features/sale/data/models/student_model.dart';
import 'package:selling_point_app/features/sale/data/repos/sale_repo.dart';

import '../models/students_model.dart';

class SaleRepoImpl extends SaleRepo {
  final ApiService apiService;

  SaleRepoImpl(this.apiService);
  @override
  Future<Either<Failure, List<StudentModels>>> getAllStudents() async {
    try {
      var response = await apiService.get(
        endPoint: 'sell-points/students',
      );
      List<StudentModels> allData = [];
      for (var student in response['data']) {
        allData.add(StudentModels.fromJson(student));
      }
      print('fetch all student success');
      return right(allData);
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
  Future<Either<Failure, StudentModel>> getStudent(String studentId) async {
    try {
      var response = await apiService.get(
        endPoint: 'sell-points/student/$studentId',
      );
      StudentModel allData = StudentModel.fromJson(response['data']);

      print('fetch single student success');
      return right(allData);
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
  Future<Either<Failure, String>> postBillSaleStudentOnline(
      Map<String, dynamic> data) async {
    try {
      var respone = await apiService.post(
        endPoint: 'sell-points/order',
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

  @override
  Future<Either<Failure, String>> postAllBillSaleStudentOffline(
    Map<String, dynamic> data,
  ) async {
    try {
      var respone = await apiService.post(
        endPoint: 'sell-points/end-day',
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

  @override
  Future<Either<Failure, String>> postCardCharge(
      Map<String, dynamic> data) async {
    try {
      var response = await apiService.post(
        endPoint: 'card-charge/',
        data: data,
      );
      return right(response['data']);
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
