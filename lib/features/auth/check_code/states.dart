part of'bloc.dart';

class CheckCodeStates {}

class CheckCodeLoadingState extends CheckCodeStates {}

class CheckCodeSuccessState extends CheckCodeStates {
  final String message;
  final BuildContext context;

  CheckCodeSuccessState({required this.message,required this.context}){
    Toast.show(message, context);
  }
}

class CheckCodeErrorState extends CheckCodeStates {
  final String message ;
  final int statueCode;
  final BuildContext context;

  CheckCodeErrorState({required this.message, required this.statueCode,required  this.context}){
    Toast.show(message,context,messageType: MessageType.error);
  }
}