import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/student_model.dart';
import '../models/students_model.dart';

abstract class SaleRepo {
  Future<Either<Failure, List<StudentModels>>> getAllStudents();
  Future<Either<Failure, StudentModel>> getStudent(String studentId);
  Future<Either<Failure, String>> postBillSaleStudentOnline(
      Map<String, dynamic> data);
  Future<Either<Failure, String>> postAllBillSaleStudentOffline(
      Map<String, dynamic> data);
  Future<Either<Failure, String>> postCardCharge(Map<String, dynamic> data);
}
