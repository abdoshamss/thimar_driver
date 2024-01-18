import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../components/orders_model.dart';

part 'states.dart';
part 'events.dart';

class PendingOrdersBloc extends Bloc<PendingOrdersEvents, PendingOrdersStates> {
  final DioHelper _dioHelper;

  PendingOrdersBloc(this._dioHelper) : super(PendingOrdersStates()) {
    on<GetPendingOrdersDataEvent>(_getData);
  }
  final searchController = TextEditingController();

  Future<void> _getData(GetPendingOrdersDataEvent event,
      Emitter<PendingOrdersStates> emit) async {
    emit(PendingOrdersLoadingState());
    final response = await _dioHelper.get("driver/pending_orders",params: {
     if(searchController.text.isNotEmpty) "keyword":event.value
    });
    final data = OrdersData.fromJson(response.response!.data);
    if (response.isSuccess) {
      emit(PendingOrdersSuccessState(data: data));
    } else {
      emit(PendingOrdersErrorState(
          message: response.message ?? "Failed",
          statusCode: response.response!.statusCode ?? 200));
    }
  }
}
