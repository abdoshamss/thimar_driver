import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/logic/dio_helper.dart';
 part 'states.dart';
part 'events.dart';

class PrivacyBloc extends Bloc<PrivacyEvents, PrivacyStates> {
  final DioHelper _dioHelper;
  PrivacyBloc(this._dioHelper) : super(PrivacyStates()) {
    on<GetPrivacyDataEvent>(_getData);
  }
  var data;

  void _getData(GetPrivacyDataEvent event, Emitter<PrivacyStates> emit) async {
    emit(PrivacyLoadingState());
    final response = await _dioHelper.get("policy");
    if (response.isSuccess) {
      data = response.response!.data["data"]["policy"];

      emit(PrivacySuccessState( ));
    } else {
      emit(PrivacyErrorState(message: response.message??"Failed", statusCode: response.response!.statusCode??200));
    }
  }
}
