part of'bloc.dart';

class RefuseOrderEvents {}

class RefuseOrderEvent extends RefuseOrderEvents {
  final int id;
final BuildContext context;

  RefuseOrderEvent({required this.id, required this.context});

}