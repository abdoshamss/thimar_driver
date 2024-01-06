part of'bloc.dart';

class LoginEvents {}

class PostLoginDataEvent extends LoginEvents {
  final BuildContext context;

  PostLoginDataEvent({required this.context});

}