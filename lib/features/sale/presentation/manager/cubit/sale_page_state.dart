part of 'sale_page_cubit.dart';

@immutable
sealed class SalePageState {}

final class SalePageInitial extends SalePageState {}

class LoadingSaleFetchStudentState extends SalePageState {}

class FailureSaleFetchStudentState extends SalePageState {
  final String errMessage;

  FailureSaleFetchStudentState(this.errMessage);
}

class SuccessSaleFetchStudent extends SalePageState {}

class SuccessSaleFetchAllStudent extends SalePageState {}

class LoadingFetchAllStudent extends SalePageState {}

class FailureFetchAllStudentState extends SalePageState {
  final String errMessage;

  FailureFetchAllStudentState(this.errMessage);
}

class LoadingCardCharge extends SalePageState {}

class FailureCardCharge extends SalePageState {
  final String errMessage;

  FailureCardCharge(this.errMessage);
}

class SuccessCardCharge extends SalePageState {}

class LoadingSaleOrder extends SalePageState {}

class FailureSaleOrder extends SalePageState {
  final String errMessage;

  FailureSaleOrder(this.errMessage);
}

class SuccessSaleOrder extends SalePageState {}
