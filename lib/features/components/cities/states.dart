part of'bloc.dart';

class CitiesStates {}

class CitiesLoadingState extends CitiesStates {}

class CitiesSuccessState extends CitiesStates {
  CitiesData data;
  CitiesSuccessState({required this.data});
}

class CitiesErrorState extends CitiesStates {
  final String message;
  final int statusCode;

  CitiesErrorState({required this.message, required this.statusCode});
}