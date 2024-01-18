part of 'bloc.dart';

class RegisterEvents {}

class PostRegisterDataEvent extends RegisterEvents {
  final BuildContext context;
  final String name, phone, location, id, email, password, confirmPassword;

  PostRegisterDataEvent(
      {required this.context,
      required this.name,
      required this.phone,
      required this.location,
      required this.id,
      required this.email,
      required this.password,
      required this.confirmPassword});
}
