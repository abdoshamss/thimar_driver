part of 'bloc.dart';

class CurrentOrdersStates {}

class CurrentOrdersLoadingState extends CurrentOrdersStates {}

class CurrentOrdersSuccessState extends CurrentOrdersStates {
  OrdersData data;

  CurrentOrdersSuccessState({required this.data});
}

class CurrentOrdersErrorState extends CurrentOrdersStates {
  final String message ;final int statusCode;

  CurrentOrdersErrorState({required this.message, required this.statusCode});
}
