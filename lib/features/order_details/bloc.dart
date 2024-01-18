import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';
part 'model.dart';

part 'states.dart';

part 'events.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvents, OrderDetailsStates> {
  final DioHelper _dioHelper;

  OrderDetailsBloc(this._dioHelper) : super(OrderDetailsStates()) {
    on<GetOrderDetailsDataEvent>(_getData);
  }

  Future<void> _getData(GetOrderDetailsDataEvent event,Emitter<OrderDetailsStates>emit) async {
    emit(OrderDetailsLoadingState());
    final response=await _dioHelper.get("driver/orders/${event.id}");
     final list =OrderDetailsData.fromJson(response.response!.data);
    if(response.isSuccess){
      emit(OrderDetailsSuccessState(data: list));
    }else{
      emit(OrderDetailsErrorState(message: response.message!,statusCode: response.response!.statusCode??200));
    }
  }
}