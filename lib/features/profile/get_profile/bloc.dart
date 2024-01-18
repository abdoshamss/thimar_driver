import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';


part 'events.dart';
part 'model.dart';

part 'states.dart';

class GetProfileBloc extends Bloc<MyAccountEvents, GetProfileStates> {
  final DioHelper _dioHelper;

  GetProfileBloc(this._dioHelper) : super(GetProfileStates()) {
    on<GetProfileDataEvent>(_getData);
  }

  Future<void> _getData(
      GetProfileDataEvent event, Emitter<GetProfileStates> emit) async {
    emit(GetProfileLoadingState());
    final response = await _dioHelper.get("driver/profile");
    final data  =ProfileData.fromJson(response.response!.data);
    if (response.isSuccess) {
      emit(GetProfileSuccessState(data: data));
    } else {
      emit(GetProfileErrorState(message: response.message!,statusCode: response.response!.statusCode??200));
    }
  }
}
