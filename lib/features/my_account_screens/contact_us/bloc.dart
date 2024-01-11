import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/widgets/toast.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';

part 'events.dart';

class ContactUsBloc extends Bloc<ContactUsEvents, ContactUsStates> {
  final DioHelper _dioHelper;

  ContactUsBloc(this._dioHelper) : super(ContactUsStates()) {
    on<GetContactUsDataEvent>(_getData);
    on<PostContactUsDataEvent>(_postData);
  }

  Future<void> _getData(
      GetContactUsDataEvent event, Emitter<ContactUsStates> emit) async {
    emit(GetContactUsDataLoadingState());
    final response = await _dioHelper.get("contact");
    final list = ContactUsData.fromJson(response.response!.data);
    if (response.isSuccess) {
      emit(GetContactUsDataSuccessState(list: list));
    } else {
      emit(GetContactUsDataErrorState(
          message: response.message ?? "Failed",
          statusCode: response.response!.statusCode ?? 200));
    }
  }

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final contentController = TextEditingController();
  Future<void> _postData(
      PostContactUsDataEvent event, Emitter<ContactUsStates> emit) async {
    emit(PostContactUsDataLoadingState());
    final response = await _dioHelper.post("contact", data: {
      "fullname": nameController.text,
      "phone": phoneController.text,
      "title": "test",
      "content": contentController.text,
    });

    if (response.isSuccess) {
      emit(PostContactUsDataSuccessState(
          message: response.message!, context: event.context));
      nameController.clear();
      phoneController.clear();
      contentController.clear();
    } else {
      emit(PostContactUsDataErrorState(
          message: response.message ?? "Failed",
          statusCode: response.response!.statusCode ?? 200,
          context: event.context));
    }
  }
}
