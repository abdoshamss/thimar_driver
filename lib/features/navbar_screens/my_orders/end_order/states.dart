part of'bloc.dart';

class EndOrderStates {}

class EndOrderLoadingState extends EndOrderStates {}

class EndOrderSuccessState extends EndOrderStates {
  final String message;
  final BuildContext context;

  EndOrderSuccessState({required this.message, required this.context}){
    Toast.show(message, context);
  }
}

class EndOrderErrorState extends EndOrderStates {
  final String message;
  final BuildContext context;
  final int statusCode;

  EndOrderErrorState({required this.message, required this.context, required this.statusCode}){
    Toast.show(message, context,messageType: MessageType.error);
  }

}