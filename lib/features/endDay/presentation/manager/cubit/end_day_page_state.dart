part of 'end_day_page_cubit.dart';

@immutable
sealed class EndDayPageState {}

final class EndDayPageInitial extends EndDayPageState {}

class LoadingEndDayState extends EndDayPageState {}

class FailureEndDayState extends EndDayPageState {
  final String errMessage;

  FailureEndDayState(this.errMessage);
}

class SuccessPostInvintory extends EndDayPageState {}

class LoadingPostEnvelopeState extends EndDayPageState {}

class FailurePostEnvelopeState extends EndDayPageState {
  final String errMessage;

  FailurePostEnvelopeState(this.errMessage);
}

class SuccessPostEnvelopeState extends EndDayPageState {}

class SuccessPostLocalData extends EndDayPageState {}

class LoadingPostExpensesState extends EndDayPageState {}

class FailurePostExpensesState extends EndDayPageState {
  final String errMessage;

  FailurePostExpensesState(this.errMessage);
}

class SuccessPostExpensesState extends EndDayPageState {}
