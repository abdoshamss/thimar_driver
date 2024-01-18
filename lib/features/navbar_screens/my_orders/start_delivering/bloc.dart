import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/logic/dio_helper.dart';
import '../../../../core/widgets/toast.dart';

part 'events.dart';

part 'states.dart';

class StartDeliveringBloc
    extends Bloc<StartDeliveringEvents, StartDeliveringStates> {
  final DioHelper _dioHelper;

  StartDeliveringBloc(this._dioHelper) : super(StartDeliveringStates()) {
    on<StartDeliveringEvent>(_startDelivering);
  }

  Future<void> _startDelivering(
      StartDeliveringEvent event, Emitter<StartDeliveringStates> emit) async {
    emit(StartDeliveringLoadingState());
    final response = await _dioHelper.get("driver/start_delivering_order/${event.id}");
    if (response.isSuccess) {
      emit(StartDeliveringSuccessState(message: response.message!,context: event.context));
    } else {
      emit(StartDeliveringErrorState(message: response.message!,context: event.context,statusCode: response.response!.statusCode??200));
    }
  }
}
