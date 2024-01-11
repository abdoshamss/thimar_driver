import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class FAQSBloc extends Bloc<FAQSEvents, FAQSStates> {
  final DioHelper _dioHelper;
  FAQSBloc(this._dioHelper) : super(FAQSStates()) {
    on<GetFAQSDataEvent>(_getData);
  }
  Future<void> _getData(
      GetFAQSDataEvent event, Emitter<FAQSStates> emit) async {
    emit(FAQSLoadingState());
    final response = await _dioHelper.get("faqs");
    final list = FAQSData.fromJson(response.response!.data).list;
    if (response.isSuccess) {
      emit(FAQSSuccessState(list: list));
    } else {
      emit(FAQSErrorState(
          message: response.message,
          statusCode: response.response!.statusCode ?? 200));
    }
  }
}
