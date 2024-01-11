import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/widgets/toast.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'events.dart';

class LogOutBLoc extends Bloc<LogOutEvents, LogOutStates> {
  final DioHelper _dioHelper;
  LogOutBLoc(this._dioHelper) : super(LogOutStates()) {
    on<PostLogOutDataEvent>(_postData);
  }
  Future<void> _postData(
      PostLogOutDataEvent event, Emitter<LogOutStates> emit) async {

    emit(LogOutLoadingState());
    final response = await _dioHelper.post("logout", data: {
      "device_token": FirebaseMessaging.instance.getToken(),
      "type": Platform.operatingSystem,
    });
    if (response.isSuccess) {
      emit(LogOutSuccessState(text: response.message!, context: event.context));
    } else {
      emit(LogOutErrorState(text:  response.message!, context: event.context, statusCode: response.response!.statusCode??200));
    }
  }
}
