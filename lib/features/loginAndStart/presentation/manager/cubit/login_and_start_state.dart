part of 'login_and_start_cubit.dart';

@immutable
sealed class LoginAndStartState {}

final class LoginAndStartInitial extends LoginAndStartState {}

class LoadingLoginAndStartState extends LoginAndStartState {}

class FailureLoginAndStartState extends LoginAndStartState {
  final String errMessage;
  FailureLoginAndStartState(this.errMessage);
}

class SuccessLoginAndStartState extends LoginAndStartState {}

class SuccessSignUpState extends LoginAndStartState {
  final LoginModel sellPointInfo;

  SuccessSignUpState(this.sellPointInfo);
}

// class AppCreatDatabaseState extends LoginAndStartState {}

// class AppinseartDatabaseState extends LoginAndStartState {}

// class AppGetDatabaseLoadingState extends LoginAndStartState {}

// class AppSuccessGetDatabaseState extends LoginAndStartState {}

// class AppFailureGetDatabaseState extends LoginAndStartState {}
