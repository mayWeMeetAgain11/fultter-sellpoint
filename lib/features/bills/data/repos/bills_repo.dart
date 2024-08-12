import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../home/data/models/category_model.dart';
import '../models/all_bills_model/all_bills_model.dart';
import '../models/bills_orderd_from_me/bills_orderd_from_me.dart';
import '../models/factory_bills_model/factory_bills_model.dart';
import '../models/sell_point.dart';
import '../models/sp_bills_model/sp_bills_model.dart';

abstract class BillsRepo {
  Future<Either<Failure, AllBillsModel>> getAllBills();
  Future<Either<Failure, List<FactoryBillsModel>>> getFactoryBills(int billID);
  Future<Either<Failure, List<SpBillsModel>>> getSpBills(int sellPintBillId);
  Future<Either<Failure, List<BillsOrderdFromMe>>> getBillsOrderFromMe();
  Future<Either<Failure, String>> postBillToFactory(Map<String, dynamic> data);
  Future<Either<Failure, String>> postBillToSp(
      int sellPointId, Map<String, dynamic> data);
  Future<Either<Failure, List<SellPoint>>> getSellPoints(
      CancelToken cancelToken);
  Future<Either<Failure, List<CategoryModel>>> getActiveCategory();

  
}
