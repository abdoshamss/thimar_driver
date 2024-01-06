part of"bloc.dart";
class ForgetPasswordEvents{}
class PostForgetPasswordDataEvent extends ForgetPasswordEvents{
  final BuildContext context;

  PostForgetPasswordDataEvent({required this.context});
}