

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/widgets/toast.dart';

part 'states.dart';
part 'events.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvents,ForgetPasswordStates> {
  final DioHelper dioHelper;
  ForgetPasswordBloc(this.dioHelper) : super(ForgetPasswordStates()){
    on<PostForgetPasswordDataEvent>(_postData);
  }

  final phoneController = TextEditingController(text: "9665412364");

  Future<void> _postData(PostForgetPasswordDataEvent event,Emitter<ForgetPasswordStates>emit) async {
    emit(ForgetPasswordLoadingState());

    final response = await dioHelper.post("forget_password", data: {
      "phone":phoneController.text
    });

    if (response.isSuccess) {
      emit(ForgetPasswordSuccessState(message: response.message!,context: event.context));
      debugPrint(response.message);
    } else {
      emit(ForgetPasswordErrorState(
          message: response.message!,
          statusCode: response.response?.statusCode ?? 200, context: event.context));
      debugPrint("Failed" * 30);
    }
  }
}
