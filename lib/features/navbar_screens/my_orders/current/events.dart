part of'bloc.dart';

class CurrentOrdersEvents {}

class GetCurrentOrdersDataEvent extends CurrentOrdersEvents {
  final String? value;

  GetCurrentOrdersDataEvent({  this.value});
}