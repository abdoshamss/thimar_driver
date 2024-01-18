part of 'bloc.dart';

class FinishedOrdersStates {}

class FinishedOrdersLoadingState extends FinishedOrdersStates {}

class FinishedOrdersSuccessState extends FinishedOrdersStates {
  OrdersData data;

  FinishedOrdersSuccessState({required this.data});
}

class FinishedOrdersErrorState extends FinishedOrdersStates {
  final String message;
  final int statusCode;

  FinishedOrdersErrorState({required this.message, required this.statusCode});
}
