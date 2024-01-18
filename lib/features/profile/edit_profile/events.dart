part of 'bloc.dart';

class EditProfileEvents {}

class PostEditProfileDataEvent extends EditProfileEvents {
  final BuildContext context;
  // final String name, phone, location, id, email;
  //
  PostEditProfileDataEvent(
      {
        required this.context,
      // required this.name,
      // required this.phone,
      // required this.location,
      // required this.id,
      // required this.email
      });
}
