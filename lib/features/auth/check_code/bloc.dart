import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/widgets/toast.dart';

part 'states.dart';
part 'events.dart';

class CheckCodeBloc extends Bloc<CheckCodeEvents,CheckCodeStates> {
  final DioHelper _dioHelper;
  CheckCodeBloc(this._dioHelper) : super(CheckCodeStates()){
    on<PostCheckCodeDataEvent>(_postData);
  }
  final codeController = TextEditingController();

  Future<void> _postData(PostCheckCodeDataEvent event,Emitter<CheckCodeStates>emit) async {
    emit(CheckCodeLoadingState());
    final map = {
      'code': codeController.text,
      'phone': event.phone,
    };
    final response = await _dioHelper.post("check_code", data: map);
    if (response.isSuccess) {
      emit(CheckCodeSuccessState(message: "تم التحقق بنجاح", context: event.context));
    } else {
      emit(CheckCodeErrorState(
          message: response.message!,
          statueCode: response.response?.statusCode ?? 200, context: event.context));


    }
  }
}
