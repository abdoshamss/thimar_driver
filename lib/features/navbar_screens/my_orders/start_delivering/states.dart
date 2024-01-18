part of'bloc.dart';

class StartDeliveringStates {}

class StartDeliveringLoadingState extends StartDeliveringStates {}

class StartDeliveringSuccessState extends StartDeliveringStates {
  final String message;
  final BuildContext context;

  StartDeliveringSuccessState({required this.message, required this.context}){
    Toast.show(message, context);
  }

}

class StartDeliveringErrorState extends StartDeliveringStates {
  final String message;
  final BuildContext context;
  final int statusCode;

  StartDeliveringErrorState({required this.message, required this.context, required this.statusCode}){
    Toast.show(message, context,messageType: MessageType.error);
  }
}