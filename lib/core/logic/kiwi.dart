import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/features/auth/check_code/bloc.dart';
import 'package:thimar_driver/features/auth/forget_password/bloc.dart';
import 'package:thimar_driver/features/auth/login/bloc.dart';
import 'package:thimar_driver/features/auth/resend_code/bloc.dart';
import 'package:thimar_driver/features/auth/reset_password/bloc.dart';

import 'dio_helper.dart';

void initKiwi() {
  KiwiContainer container = KiwiContainer();
  container.registerSingleton((container) => DioHelper());
  container.registerFactory((c) => LoginBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => ForgetPasswordBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => CheckCodeBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => ResendCodeBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => ResetPasswordBloc(c.resolve<DioHelper>()));
}
