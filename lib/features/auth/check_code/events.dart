part of 'bloc.dart';
class CheckCodeEvents{}
class PostCheckCodeDataEvent extends CheckCodeEvents{
  final BuildContext context;
  final String phone;

  PostCheckCodeDataEvent({required this.context, required this.phone});
}
