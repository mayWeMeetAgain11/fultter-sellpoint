import 'package:dartz/dartz.dart';
import 'package:selling_point_app/features/home/data/models/category_model.dart';
import 'package:selling_point_app/features/loginAndStart/data/models/login_model/login_model.dart';

import '../../../../core/errors/failures.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginModel>> postLoginSellPoint(
      Map<String, dynamic> data);
  // Future<Either<Failure, List<CategoryModel>>> getActiveCategory();
}
