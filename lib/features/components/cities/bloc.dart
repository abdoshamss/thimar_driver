import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';

part 'events.dart';

part 'model.dart';

part 'states.dart';

class CitiesBloc extends Bloc<CitiesEvents, CitiesStates> {
  final DioHelper _dioHelper;

  CitiesBloc(this._dioHelper) : super(CitiesStates()) {
    on<GetCitiesDataEvent>(_getCities);
  }

  Future<void> _getCities(
      GetCitiesDataEvent event, Emitter<CitiesStates> emit) async {
    emit(CitiesLoadingState());
    final response = await _dioHelper.get("cities/1");
    final data = CitiesData.fromJson(response.response!.data);
    if (response.isSuccess) {
      emit(CitiesSuccessState(data: data));
    } else {
      emit(CitiesErrorState(
          message: response.message!,
          statusCode: response.response!.statusCode ?? 200));
    }
  }
}
