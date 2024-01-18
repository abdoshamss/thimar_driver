part of'bloc.dart';

class EditPasswordStates {}

class EditPasswordLoadingState extends EditPasswordStates {}

class EditPasswordSuccessState extends EditPasswordStates {
  final String message;
final BuildContext context;
  EditPasswordSuccessState( {required this.context,required this.message}){
    Toast.show(message,context);
  }
}

class EditPasswordErrorState extends EditPasswordStates {
  final String message;
  final int statueCode;
  final BuildContext context;

  EditPasswordErrorState({required this.message, required this.statueCode,required this.context}){
    Toast.show(message,context,messageType: MessageType.error);
  }
}