import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/category_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CategoryModel>>> getActiveCategory();
  Future<Either<Failure, bool>> checkForCAtegory();
}
