part of'bloc.dart';
class LogOutEvents{}
class PostLogOutDataEvent extends LogOutEvents{
  final BuildContext context;

  PostLogOutDataEvent({required this.context});
}