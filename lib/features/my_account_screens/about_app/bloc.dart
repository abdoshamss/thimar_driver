import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'events.dart';

class AboutAppBloc extends Bloc<AboutDataEvents, AboutAppStates> {
  final DioHelper _dioHelper;
  AboutAppBloc(this._dioHelper) : super(AboutAppStates()) {
    on<GetAboutDataEvent>(_getAboutData);
  }

  var data;

  Future<void> _getAboutData(
      GetAboutDataEvent event, Emitter<AboutAppStates> emit) async {
    emit(GetAboutDetailsLoadingState());
    final response = await _dioHelper.get("about");


    if (response.isSuccess) {
      emit(GetAboutDetailsSuccessState(message: response.message!));
    data= response.response!.data["data"]["about"];
      debugPrint(response.message);
    } else {
      emit(GetAboutDetailsErrorState(statusCode: response.response!.statusCode??200, message: response.message));
      debugPrint(response.message);
    }
  }
}
