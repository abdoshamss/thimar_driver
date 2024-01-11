part of 'bloc.dart';

class ContactUsStates {}

class GetContactUsDataLoadingState extends ContactUsStates {}

class GetContactUsDataSuccessState extends ContactUsStates {
  ContactUsData list;
  GetContactUsDataSuccessState({required this.list});
}

class GetContactUsDataErrorState extends ContactUsStates {
  final String message;
  final int statusCode;

  GetContactUsDataErrorState(
      {required this.message, required this.statusCode});
}

class PostContactUsDataLoadingState extends ContactUsStates {}

class PostContactUsDataSuccessState extends ContactUsStates {
  final String message;
  final BuildContext context;
  PostContactUsDataSuccessState({required this.message,required this.context}) {
    Toast.show(message, context);

  }
}

class PostContactUsDataErrorState extends ContactUsStates {
  final String message;
  final int statusCode;
  final BuildContext context;
  PostContactUsDataErrorState(
      {required this.message, required this.statusCode,required this.context}) {
    Toast.show(message, context, messageType: MessageType.error);

  }
}
