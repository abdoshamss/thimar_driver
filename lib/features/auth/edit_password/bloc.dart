import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/widgets/toast.dart';

part 'states.dart';
part 'events.dart';

class EditPasswordBloc extends Bloc<EditPasswordEvents, EditPasswordStates> {
  final DioHelper dioHelper;
  EditPasswordBloc(this.dioHelper) : super(EditPasswordStates()) {
    on<PostEditPasswordDataEvent>(_postData);
  }

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  Future<void> _postData(
      PostEditPasswordDataEvent event, Emitter<EditPasswordStates> emit) async {
    emit(EditPasswordLoadingState());

    final response = await dioHelper.post("edit_password", data: {
    "old_password": oldPasswordController.text,
    "password": confirmNewPasswordController.text,
      "_method": "PUT",    });
    if (response.isSuccess) {
      emit(EditPasswordSuccessState(message: response.message!, context: event.context));
    } else {
      emit(EditPasswordErrorState(
        message: response.message!,
        statueCode: response.response?.statusCode ?? 200, context: event.context,
      ));
    }
  }
}
