part of'bloc.dart';

class OrderDetailsEvents {}

class GetOrderDetailsDataEvent extends OrderDetailsEvents {
  final int id;

  GetOrderDetailsDataEvent({required this.id});
}