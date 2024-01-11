part of'bloc.dart';

class PendingOrdersStates {}

class PendingOrdersLoadingState extends PendingOrdersStates {}

class PendingOrdersSuccessState extends PendingOrdersStates {
   OrdersData data;
  PendingOrdersSuccessState({required this .data});
}

class PendingOrdersErrorState extends PendingOrdersStates {
  final String message;
  final int statusCode;

  PendingOrdersErrorState({required this.message, required this.statusCode});
}