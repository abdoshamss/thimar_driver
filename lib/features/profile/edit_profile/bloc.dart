import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/widgets/toast.dart';

import '../../../core/logic/cache_helper.dart';
import '../../../core/logic/dio_helper.dart';

part 'events.dart';

part 'states.dart';

class EditProfileBloc extends Bloc<EditProfileEvents, EditProfileStates> {
  final DioHelper _dioHelper;

  EditProfileBloc(this._dioHelper) : super(EditProfileStates()) {
    on<PostEditProfileDataEvent>(_editProfile);
  }

  final nameController = TextEditingController(text: CacheHelper.getFullName());
  final phoneController = TextEditingController(text: CacheHelper.getPhone());
  final cityController = TextEditingController(text: CacheHelper.getCity());
  final idController = TextEditingController(text: "");
  int? cityId;
  int? modelId;

  final carTypeController = TextEditingController();
  final carModelController = TextEditingController();
  final ibanNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  File? userImage,
      licenseImage,
      carFormImage,
      carInsurance,
      frontCarImage,
      behindCarImage;

  Future<void> _editProfile(
      PostEditProfileDataEvent event, Emitter<EditProfileStates> emit) async {
    emit(EditProfileLoadingState());

    final response = await _dioHelper.post("driver/profile", data: {
      "fullname": nameController.text,
      "phone": phoneController.text,

      if (userImage != null)
        "image": MultipartFile.fromFileSync(userImage!.path,
            filename: userImage!.path.split("/").last),
      "identity_number": idController.text,
      if (licenseImage != null)
        "car_licence_image": MultipartFile.fromFileSync(licenseImage!.path,
            filename: licenseImage!.path.split("/").last),
      if (carFormImage != null)
        "car_form_image": MultipartFile.fromFileSync(carFormImage!.path,
            filename: carFormImage!.path.split("/").last),
      if (carInsurance != null)
        "car_insurance_image": MultipartFile.fromFileSync(carInsurance!.path,
            filename: carInsurance!.path.split("/").last),
      if (frontCarImage != null)
        "car_front_image": MultipartFile.fromFileSync(frontCarImage!.path,
            filename: frontCarImage!.path.split("/").last),
      if (behindCarImage != null)
        "car_back_image": MultipartFile.fromFileSync(behindCarImage!.path,
            filename: behindCarImage!.path.split("/").last),
      if (cityId != null) "city_id": cityId,
      "iban": ibanNumberController.text,
      "bank_name": bankNameController.text,
      "car_type": carTypeController.text,
      "model_id": carModelController.text,

    });
    if (response.isSuccess) {

      emit(EditProfileSuccessState(
          context: event.context,
          message: response.message!,
          image: userImage?.path));
      await CacheHelper.setFullName(nameController.text);
      await CacheHelper.setPhone(phoneController.text);
      await CacheHelper.setCityName(cityController.text);
    } else {
      emit(EditProfileErrorState(
          context: event.context,
          message: response.message!,
          statusCode: response.response!.statusCode ?? 200));
    }
  }
}
