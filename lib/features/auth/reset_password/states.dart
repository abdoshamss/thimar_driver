part of 'bloc.dart';

class ResetPasswordStates {}

class ResetPasswordLoadingState extends ResetPasswordStates {}

class ResetPasswordSuccessState extends ResetPasswordStates {
  final String message;
  final BuildContext context;

  ResetPasswordSuccessState({required this.message, required this.context}) {
    Toast.show(message, context);
  }
}

class ResetPasswordErrorState extends ResetPasswordStates {
  final String message;
  final int statueCode;
  final BuildContext context;
  ResetPasswordErrorState(
      {required this.message,
      required this.statueCode,
      required this.context}) {
    Toast.show(message, context, messageType: MessageType.error);
  }
}
