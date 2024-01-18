part of'bloc.dart';

class GetProfileStates {}

class GetProfileLoadingState extends GetProfileStates {}

class GetProfileSuccessState extends GetProfileStates {
  ProfileData data;
  GetProfileSuccessState({required this.data});
}

class GetProfileErrorState extends GetProfileStates {
  final String message ;
  final int statusCode;

  GetProfileErrorState({required this.message, required this.statusCode});
}