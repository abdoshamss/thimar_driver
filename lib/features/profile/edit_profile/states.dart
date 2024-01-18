part of'bloc.dart';

class EditProfileStates {}

class EditProfileLoadingState extends EditProfileStates {}

class EditProfileSuccessState extends EditProfileStates {
  final BuildContext context;
  final  String message;
  final  String? image;

  EditProfileSuccessState({required this.context, required this.message,required this.image}){
    Toast.show(message, context);
      debugPrint(image??"image is null");
    if(image!=null) {
      CacheHelper.setImage(image!);
    }
  }
}

class EditProfileErrorState extends EditProfileStates {
  final BuildContext context;
  final  String message;
final int statusCode;
  EditProfileErrorState({required this.context, required this.message, required this.statusCode}){
    Toast.show(message, context,messageType: MessageType.error);
  }

}