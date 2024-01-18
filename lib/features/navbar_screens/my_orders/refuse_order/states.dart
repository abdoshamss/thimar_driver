part of'bloc.dart';

class RefuseOrderStates {}

class RefuseOrderLoadingState extends RefuseOrderStates {}

class RefuseOrderSuccessState extends RefuseOrderStates {

  final BuildContext context;

  RefuseOrderSuccessState({  required this.context}){
    Toast.show("تم رفض الطلب بنجاح", context);
  }

}

class RefuseOrderErrorState extends RefuseOrderStates {
  final String message;
  final BuildContext context;
  final int statusCode;

  RefuseOrderErrorState({required this.message, required this.context, required this.statusCode}){
    Toast.show(message, context,messageType: MessageType.error);
  }
}