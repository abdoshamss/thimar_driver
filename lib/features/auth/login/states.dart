part of'bloc.dart';

class LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String message;
final BuildContext context;
  LoginSuccessState( {required this.message,required this.context,}){
    Toast.show(message, context);

   push(  HomeNavBarScreen(),c: context);
  }

}

class LoginErrorState extends LoginStates {
  final String message;
final int statusCode;
  final BuildContext context;
  LoginErrorState({required this.message, required this.statusCode,required this.context,}){
Toast.show(message,context,messageType: MessageType.error);

  }

}