import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/widgets/toast.dart';

import '../../../../core/logic/dio_helper.dart';

part 'events.dart';

part 'states.dart';

class EndOrderBloc extends Bloc<EndOrderEvents, EndOrderStates> {
  final DioHelper _dioHelper;

  EndOrderBloc(this._dioHelper) : super(EndOrderStates()) {
    on<EndOrderEvent>(_endOrder);
  }
final amountController=TextEditingController();
  Future<void> _endOrder(
      EndOrderEvent event, Emitter<EndOrderStates> emit) async {
    emit(EndOrderLoadingState());
    final response = await _dioHelper.get("driver/finish_order/${event.id}",
        params: {"client_paid_amount": amountController.text});
    if (response.isSuccess) {
      emit(EndOrderSuccessState(message: response.message!,context: event.context));
    } else {
      emit(EndOrderErrorState(message: response.message!,context: event.context,statusCode: response.response!.statusCode??200));
    }
  }
}
