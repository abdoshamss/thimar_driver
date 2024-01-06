part of'bloc.dart';

class ResendCodeStates {}

class ResendCodeLoadingState extends ResendCodeStates {}

class ResendCodeSuccessState extends ResendCodeStates {
  final String message;
  final BuildContext context;
  ResendCodeSuccessState({required this.message,required this.context}) {
    // Toast.show(message,context);
   }
}

class ResendCodeErrorState extends ResendCodeStates {
  final String message;
  final int statusCode;
  final BuildContext context;
  ResendCodeErrorState({required this.message, required this.statusCode,required this.context }){
    // Toast.show(message,context,messageType: MessageType.error);

  }
}