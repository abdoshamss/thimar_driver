import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/cache_helper.dart';
import 'package:thimar_driver/core/widgets/pusher.dart';
import 'package:thimar_driver/core/widgets/toast.dart';
import 'package:thimar_driver/screens/home/view.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final DioHelper _dioHelper;

  LoginBloc(this._dioHelper) : super(LoginStates()) {
    on<PostLoginDataEvent>(_postData);
  }
  final phoneController = TextEditingController(text: "9665412364");
  final passwordController = TextEditingController(text: "123456789");
  Future<void> _postData(
      PostLoginDataEvent event, Emitter<LoginStates> emit) async {
    emit(LoginLoadingState());
    final response = await _dioHelper.post("login", data: {
      "phone": phoneController.text,
      "password": passwordController.text,
      "device_token": FirebaseMessaging.instance.getToken(),
      "type": Platform.operatingSystem,
      "user_type": "driver"
    });
    if (response.isSuccess) {
      await CacheHelper.saveLoginData(
          UserData.fromJson(response.response!.data));
      emit(LoginSuccessState(
          message: "تم تسجيل الدخول بنجاح", context: event.context));
    } else {
      emit(LoginErrorState(
          context: event.context,
          message: response.message!,
          statusCode: response.response!.statusCode ?? 200));
    }
  }
}