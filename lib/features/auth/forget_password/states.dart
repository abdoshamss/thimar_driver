part of'bloc.dart';

class ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {}

class ForgetPasswordSuccessState extends ForgetPasswordStates {
  final String message;
final BuildContext context;
  ForgetPasswordSuccessState( {required this.message,required this.context,}){
    Toast.show(message,context);
}}

class ForgetPasswordErrorState extends ForgetPasswordStates {
  final String message;
  final int statusCode;
  final BuildContext context;

  ForgetPasswordErrorState({required this.message, required this.statusCode,required this.context}){
    Toast.show(message,context,messageType: MessageType.error);
  }
}