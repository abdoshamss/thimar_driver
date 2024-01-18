import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/logic/dio_helper.dart';
import '../../components/orders_model.dart';

part 'states.dart';

part 'events.dart';

class FinishedOrdersBloc extends Bloc<FinishedOrdersEvents, FinishedOrdersStates> {
  final DioHelper _dioHelper;

  FinishedOrdersBloc(this._dioHelper) : super(FinishedOrdersStates()) {
    on<GetFinishedOrderDataEvent>(_getData);
  }
  final searchController = TextEditingController();
  Future<void> _getData(GetFinishedOrderDataEvent event,
      Emitter<FinishedOrdersStates> emit) async {
    emit(FinishedOrdersLoadingState());
    final response = await _dioHelper.get("driver/finished_orders",params: {
      if(searchController.text.isNotEmpty)"keyword":event.value
    });
    final data = OrdersData.fromJson(response.response!.data);
    if (response.isSuccess) {
      emit(FinishedOrdersSuccessState(data: data));
    } else {
      emit(FinishedOrdersErrorState(message: response.message!,statusCode: response.response!.statusCode??200));
    }
  }
}
