import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/widgets/app_button.dart';
import 'package:thimar_driver/core/widgets/pusher.dart';
import 'package:thimar_driver/gen/assets.gen.dart';
import 'package:thimar_driver/screens/home/view.dart';

import '../../../../core/logic/dio_helper.dart';

part 'events.dart';

part 'states.dart';

class AcceptOrderBloc extends Bloc<AcceptOrderEvents, AcceptOrderStates> {
  final DioHelper _dioHelper;

  AcceptOrderBloc(this._dioHelper) : super(AcceptOrderStates()) {
    on<AcceptOrderEvent>(_acceptOrder);
  }

  Future<void> _acceptOrder(
      AcceptOrderEvent event, Emitter<AcceptOrderStates> emit) async {
    emit(AcceptOrderLoadingState());
    final response = await _dioHelper.get("driver/accept_order/${event.id}");

    if (response.isSuccess) {
      emit(AcceptOrderSuccessState(message: response.message!,context:event.context));
    } else {
      emit(AcceptOrderErrorState(
          message: response.message!,
          statusCode: response.response!.statusCode ?? 200));
    }
  }
}
