import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/logic/dio_helper.dart';
import '../../components/orders_model.dart';

part 'states.dart';

part 'events.dart';

class CurrentOrdersBloc extends Bloc<CurrentOrdersEvents, CurrentOrdersStates> {
  final DioHelper _dioHelper;

  CurrentOrdersBloc(this._dioHelper) : super(CurrentOrdersStates()) {
    on<GetCurrentOrdersDataEvent>(_getData);
  }
  final searchController = TextEditingController();
  Future<void> _getData(GetCurrentOrdersDataEvent event,
      Emitter<CurrentOrdersStates> emit) async {
    emit(CurrentOrdersLoadingState());
    final response = await _dioHelper.get("driver/orders?status=current",params: {
      if(searchController.text.isNotEmpty)"keyword":event.value
    });
    final data = OrdersData.fromJson(response.response!.data);
    if (response.isSuccess) {
      emit(CurrentOrdersSuccessState(data: data));
    } else {
      emit(CurrentOrdersErrorState(message: response.message!,statusCode: response.response!.statusCode??200));
    }
  }
}
