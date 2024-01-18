import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/widgets/toast.dart';

import '../../../../core/logic/dio_helper.dart';

part 'events.dart';

part 'states.dart';

class RefuseOrderBloc extends Bloc<RefuseOrderEvents, RefuseOrderStates> {
  final DioHelper _dioHelper;

  RefuseOrderBloc(this._dioHelper) : super(RefuseOrderStates()) {
    on<RefuseOrderEvent>(_refuseOrder);
  }

  Future<void> _refuseOrder(
      RefuseOrderEvent event, Emitter<RefuseOrderStates> emit) async {
    emit(RefuseOrderLoadingState());
    final response = await _dioHelper.get("driver/refuse_order/${event.id}");
    if (response.isSuccess) {
      emit(RefuseOrderSuccessState(context: event.context));
    } else {
      emit(RefuseOrderErrorState(message: response.message!,context: event.context,statusCode: response.response!.statusCode??200));
    }
  }
}
