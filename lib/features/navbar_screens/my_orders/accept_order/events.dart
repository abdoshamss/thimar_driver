part of'bloc.dart';

class AcceptOrderEvents {}

class AcceptOrderEvent extends AcceptOrderEvents {
  final int id;
final BuildContext context;
  AcceptOrderEvent( {required this.id,required this.context});
}