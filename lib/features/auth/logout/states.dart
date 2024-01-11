part of'bloc.dart';

class LogOutStates {}

class LogOutLoadingState extends LogOutStates {}

class LogOutSuccessState extends LogOutStates {
  final String text;
final BuildContext context;
  LogOutSuccessState( {required this.text,required this.context}) {


 Toast.show(text, context);

  }
}

class LogOutErrorState extends LogOutStates {
  final String text;
  final BuildContext context;
final int statusCode;
  LogOutErrorState( {required this.text,required this.context,required this.statusCode,}){
    Toast.show(text, context,messageType: MessageType.error);
  }
}