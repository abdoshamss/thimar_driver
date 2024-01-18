import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/cache_helper.dart';
import 'package:thimar_driver/core/widgets/toast.dart';

import '../../../core/logic/dio_helper.dart';

part 'events.dart';

part 'states.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  final DioHelper _dioHelper;

  RegisterBloc(this._dioHelper) : super(RegisterStates()) {
    on<PostRegisterDataEvent>(_postData);
  }



  final carTypeController = TextEditingController();
  final carModelController = TextEditingController();
  final ibanNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  File? licenseImage, carFormImage, carInsurance, frontCarImage, behindCarImage;
   late int cityId;

  late int modelId;

  Future<void> _postData(
      PostRegisterDataEvent event, Emitter<RegisterStates> emit) async {
    emit(RegisterLoadingState());
    final response = await _dioHelper.post("driver_register", data: {
      "fullname":event.name,
      "phone":  event.phone,
      "city_id": cityId,
      "lat": CacheHelper.getLat(),
      "lng": CacheHelper.getLongitude(),
      "location": event.location,
      "identity_number": event.id,
      "email": event.email,
      "password": event.password,
      "password_confirmation": event.confirmPassword,
      "car_licence_image": MultipartFile.fromFileSync(licenseImage!.path,
          filename: licenseImage!.path.split("/").last),
      "car_form_image": MultipartFile.fromFileSync(carFormImage!.path,
          filename: carFormImage!.path.split("/").last),
      "car_insurance_image": MultipartFile.fromFileSync(carInsurance!.path,
          filename: carInsurance!.path.split("/").last),
      "car_front_image": MultipartFile.fromFileSync(frontCarImage!.path,
          filename: frontCarImage!.path.split("/").last),
      "car_back_image": MultipartFile.fromFileSync(behindCarImage!.path,
          filename: behindCarImage!.path.split("/").last),
      "car_type": carTypeController.text,
      "model_id": carModelController.text,
      "iban": ibanNumberController.text,
      "bank_name": bankNameController.text
    });
    if (response.isSuccess) {
      emit(RegisterSuccessState(
          context: event.context, message: response.message!));
    } else {
      emit(RegisterErrorState(
          context: event.context,
          message: response.message!,
          statusCode: response.response!.statusCode ?? 200));
    }
  }
}
