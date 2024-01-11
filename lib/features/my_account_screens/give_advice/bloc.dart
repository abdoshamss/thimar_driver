import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/widgets/toast.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'events.dart';

class GiveAdviceBloc extends Bloc<GiveAdviceEvents, GiveAdviceStates> {
  final DioHelper _dioHelper;
  GiveAdviceBloc(this._dioHelper) : super(GiveAdviceStates()) {
    on<PostGiveAdviceDataEvent>(_postData);
  }
  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final titleController = TextEditingController();

  final contentController = TextEditingController();
  Future<void> _postData(
      PostGiveAdviceDataEvent event, Emitter<GiveAdviceStates> emit) async {
    emit(GiveAdviceLoadingState());

    final response = await _dioHelper.post("contact", data: {
      "fullname": nameController.text,
      "phone": phoneController.text,
      "title": titleController.text,
      "content": contentController.text,
    });

    if (response.isSuccess) {

      emit(GiveAdviceSuccessState(message: response.message!, context: event.context));
      nameController.clear();
      phoneController.clear();
      titleController.clear();
      contentController.clear();
    } else {
      emit(GiveAdviceErrorState(
          message: response.message!,
          statusCode: response.response!.statusCode ?? 200, context: event.context));
    }
  }
}
