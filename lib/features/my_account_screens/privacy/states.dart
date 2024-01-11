part of 'bloc.dart';

class PrivacyStates {}

class PrivacyLoadingState extends PrivacyStates {}

class PrivacySuccessState extends PrivacyStates {

}

class PrivacyErrorState extends PrivacyStates {
  final String message;
  final int statusCode;

  PrivacyErrorState({required this.message, required this.statusCode});
}