part of'bloc.dart';

class PendingOrdersEvents {}

class GetPendingOrdersDataEvent extends PendingOrdersEvents {
  final String? value;

  GetPendingOrdersDataEvent({  this.value});
}