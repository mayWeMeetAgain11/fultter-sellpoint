part of 'bill_page_cubit.dart';

@immutable
sealed class BillPageState {}

final class BillPageInitial extends BillPageState {}

class LoadingBillState extends BillPageState {}

class LoadingPostToFactoryBillState extends BillPageState {}

class LoadingPostToSpBillState extends BillPageState {}

class SuccessToFactoryBillState extends BillPageState {
  final List<BillsToFactory> billsToFActory;

  SuccessToFactoryBillState(this.billsToFActory);
}

class SuccessPostBill extends BillPageState {}

class SuccessToSpBillState extends BillPageState {
  final List<BillsToSellPoint> billsToSp;

  SuccessToSpBillState(this.billsToSp);
}

class FailureBillState extends BillPageState {
  final String errMessage;

  FailureBillState(this.errMessage);
}

class LoadingGetSingleBillState extends BillPageState {}

class SuccessGetBillFromMe extends BillPageState {}

class FailurePostData extends BillPageState {
  final String errMessage;

  FailurePostData(this.errMessage);
}

class SuccessGetSellPoints extends BillPageState {}

class LoadingActiveCategoryState extends BillPageState {}

class FailureActivecategoryState extends BillPageState {
  final String errMessage;

  FailureActivecategoryState(this.errMessage);
}

class SuccessActiveCategoryState extends BillPageState {}
