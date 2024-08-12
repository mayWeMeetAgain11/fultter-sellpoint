import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class EndDayRepo {
  Future<Either<Failure, String>> postInvintory(Map<String, dynamic> data);
  Future<Either<Failure, String>> postEnvelope(
      Map<String, dynamic> data, int sellPointID);
  Future<Either<Failure, String>> postExpensesToFactory(
      Map<String, dynamic> data);
}
