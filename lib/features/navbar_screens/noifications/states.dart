part of'bloc.dart';

class NotificationsStates {}

class NotificationsLoadingState extends NotificationsStates {}

class NotificationsSuccessState extends NotificationsStates {
NotificationData data;
NotificationsSuccessState ({required this.data});
}

class NotificationsErrorState extends NotificationsStates {
  final String message;
  final int statusCode;

  NotificationsErrorState({required this.message, required this.statusCode});
}