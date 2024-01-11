import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'events.dart';

class ResendCodeBloc extends Bloc<ResendCodeEvents,ResendCodeStates> {
  final DioHelper _dioHelper;
  ResendCodeBloc(this._dioHelper) : super(ResendCodeStates()){
    on<PostResendCodeDataEvent>(_postData);
  }

  Future<void>  _postData(PostResendCodeDataEvent event,Emitter<ResendCodeStates>emit) async {
    emit(ResendCodeLoadingState());

    final response = await _dioHelper.post("resend_code", data: {
      "phone": event.phone,
    });

    if (response.isSuccess) {
      emit(ResendCodeSuccessState(
        message: response.message!, context: event.context,
      ));

    } else {
      emit(ResendCodeErrorState(
          message: response.message!,
          statusCode: response.response?.statusCode ?? 200, context: event.context));
    }

  }
}
