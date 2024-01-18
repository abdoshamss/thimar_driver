import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class NotificationsBloc extends Bloc<NotificationsEvents, NotificationsStates> {
  final DioHelper _dioHelper;

  NotificationsBloc(this._dioHelper) : super(NotificationsStates()) {
  on<GetNotificationsDataEvent>(_getData);
  }

  Future<void> _getData(GetNotificationsDataEvent event,Emitter<NotificationsStates>emit) async {
    emit(NotificationsLoadingState());

    final response =await  _dioHelper.get("notifications");
    final data =NotificationData.fromJson(response.response!.data);
    if(response.isSuccess){
      emit(NotificationsSuccessState(data: data));
    }else{
      emit(NotificationsErrorState(message: response.message!,statusCode: response.response!.statusCode??200));
    }
  }
}