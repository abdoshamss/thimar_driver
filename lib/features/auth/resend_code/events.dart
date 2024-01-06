part of'bloc.dart';
class ResendCodeEvents{}
class PostResendCodeDataEvent extends ResendCodeEvents{
  final String phone;
final BuildContext context;
  PostResendCodeDataEvent( {required this.phone,required this.context});
}