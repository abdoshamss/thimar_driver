part of'bloc.dart';

class FinishedOrdersEvents {}

class GetFinishedOrderDataEvent extends FinishedOrdersEvents {
  final String? value;

  GetFinishedOrderDataEvent({  this.value});
}