import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:selling_point_app/core/errors/failures.dart';
import 'package:selling_point_app/core/utils/api_service.dart';
import 'package:selling_point_app/features/bills/data/models/all_bills_model/all_bills_model.dart';
import 'package:selling_point_app/features/bills/data/models/factory_bills_model/factory_bills_model.dart';
import 'package:selling_point_app/features/bills/data/models/sp_bills_model/sp_bills_model.dart';
import 'package:selling_point_app/features/bills/data/repos/bills_repo.dart';
import 'package:selling_point_app/features/home/data/models/category_model.dart';

import '../models/bills_orderd_from_me/bills_orderd_from_me.dart';
import '../models/sell_point.dart';

class BillsRepoimpl extends BillsRepo {
  final ApiService apiService;

  BillsRepoimpl(this.apiService);
  @override
  Future<Either<Failure, AllBillsModel>> getAllBills() async {
    try {
      var response = await apiService.get(
        endPoint: 'sell-points/bills',
      );
      AllBillsModel allData = AllBillsModel.fromJson(response['data']);
      print('fetch all bills success');
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
  Future<Either<Failure, List<FactoryBillsModel>>> getFactoryBills(
      int billID) async {
    try {
      var response = await apiService.get(
        endPoint: 'sell-points/bill-factory/$billID',
      );
      List<FactoryBillsModel> factoryBillsData = [];
      for (var item in response['data']) {
        factoryBillsData.add(FactoryBillsModel.fromJson(item));
      }
      return right(factoryBillsData);
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
  Future<Either<Failure, List<SpBillsModel>>> getSpBills(
      int sellPintBillId) async {
    try {
      var response = await apiService.get(
        endPoint: 'sell-points/bill-sell-point/$sellPintBillId',
      );
      List<SpBillsModel> spBillsData = [];
      for (var item in response['data']) {
        spBillsData.add(SpBillsModel.fromJson(item));
      }
      return right(spBillsData);
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
  Future<Either<Failure, List<BillsOrderdFromMe>>> getBillsOrderFromMe() async {
    try {
      var response = await apiService.get(
        endPoint: 'sell-points/bill-to-sell-point',
      );
      List<BillsOrderdFromMe> billsFromMe = [];
      for (var item in response['data']) {
        billsFromMe.add(BillsOrderdFromMe.fromJson(item));
      }
      return right(billsFromMe);
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
  Future<Either<Failure, String>> postBillToFactory(
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

  @override
  Future<Either<Failure, String>> postBillToSp(
      int sellPointId, Map<String, dynamic> data) async {
    try {
      var response = await apiService.post(
        endPoint: 'sell-points/bills/sell-point/$sellPointId',
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
  Future<Either<Failure, List<SellPoint>>> getSellPoints(
      CancelToken cancelToken) async {
    try {
      var response = await apiService.get(
        endPoint: 'sell-points/',
      );
      List<SellPoint> sellPoints = [];
      for (var item in response['data']) {
        sellPoints.add(SellPoint.fromJson(item));
      }
      return right(sellPoints);
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
}
