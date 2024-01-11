part of'bloc.dart';
class GiveAdviceStates {}

class GiveAdviceLoadingState extends GiveAdviceStates{}
class GiveAdviceSuccessState extends GiveAdviceStates{
 final  String  message;
 final BuildContext context;
  GiveAdviceSuccessState({required this.message,required this.context}){
    Toast.show(message, context);
  }
}
class GiveAdviceErrorState extends GiveAdviceStates{
  final String message;
  final int statusCode;
final BuildContext context;
  GiveAdviceErrorState({required this.message, required this.statusCode,required this.context}){
    Toast.show(message, context,messageType: MessageType.error,);

  }
}