part of'bloc.dart';

class EndOrderEvents {}

class EndOrderEvent extends EndOrderEvents {
  final int id;

final BuildContext context;

  EndOrderEvent({required this.id,  required this.context});

}