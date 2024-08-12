part of 'home_page_cubit.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

// class LoadingLoginAndStartState extends HomePageState {}
class LoadingfetchActiveCatState extends HomePageState {}

class SuccessLoginAndStartState extends HomePageState {}

class FailureHomePageState extends HomePageState {
  final String errMessage;

  FailureHomePageState(this.errMessage);
}

class AppCreatDatabaseState extends HomePageState {}

class AppGetDatabaseLoadingState extends HomePageState {}

class AppSuccessGetDatabaseState extends HomePageState {}

class AppFailureGetDatabaseState extends HomePageState {}
