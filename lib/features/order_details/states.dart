part of'bloc.dart';

class OrderDetailsStates {}

class OrderDetailsLoadingState extends OrderDetailsStates {}

class OrderDetailsSuccessState extends OrderDetailsStates {
  OrderDetailsData data;
  OrderDetailsSuccessState({required this.data});
}

class OrderDetailsErrorState extends OrderDetailsStates {
  final String message;
  final int statusCode;

  OrderDetailsErrorState({required this.message, required this.statusCode});

}