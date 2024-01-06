part of 'bloc.dart';

class ResetPasswordEvents {}

class PostResetPasswordDataEvent extends ResetPasswordEvents {
  final String phone, code;
  final BuildContext context;
  PostResetPasswordDataEvent(
      {required this.phone, required this.code, required this.context});
}
