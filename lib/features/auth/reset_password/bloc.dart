import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/widgets/toast.dart';
part 'states.dart';
part 'events.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvents, ResetPasswordStates> {
  final DioHelper dioHelper;
  ResetPasswordBloc(this.dioHelper) : super(ResetPasswordStates()) {
    on<PostResetPasswordDataEvent>(_postData);
  }

  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  Future<void> _postData(PostResetPasswordDataEvent event,
      Emitter<ResetPasswordStates> emit) async {
    emit(ResetPasswordLoadingState());

    final response = await dioHelper.post("reset_password", data: {
      "phone": event.phone,
      "code": event.code,
      "password": confirmNewPasswordController.text,
    });
    if (response.isSuccess) {
      emit(ResetPasswordSuccessState(
          message: response.message!, context: event.context));
    } else {
      emit(ResetPasswordErrorState(
          message: response.message!,
          statueCode: response.response?.statusCode ?? 200,
          context: event.context));
    }
  }
}
