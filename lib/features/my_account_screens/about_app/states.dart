
part of 'bloc.dart';
class AboutAppStates {}



class GetAboutDetailsLoadingState extends AboutAppStates{}
class GetAboutDetailsSuccessState extends AboutAppStates{
  final String message;

  GetAboutDetailsSuccessState({required this.message});

}
class GetAboutDetailsErrorState extends AboutAppStates{
  final String? message;
 final int statusCode;
  GetAboutDetailsErrorState( {required this.statusCode,required this.message});
}
