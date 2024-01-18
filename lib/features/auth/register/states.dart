part of'bloc.dart';

class RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final String message ;
  final BuildContext context;
  RegisterSuccessState(  {required this.context,required this.message}){
    Toast.show(message, context);
  }
}

class RegisterErrorState extends RegisterStates {
  final String message ;
  final int statusCode;
  final BuildContext context;
  RegisterErrorState(  {required this.context,required this.message,required this.statusCode}){
    Toast.show(message, context,messageType: MessageType.error);
  }


}