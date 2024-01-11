import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/features/auth/check_code/bloc.dart';
import 'package:thimar_driver/features/auth/forget_password/bloc.dart';
import 'package:thimar_driver/features/auth/login/bloc.dart';
import 'package:thimar_driver/features/auth/resend_code/bloc.dart';
import 'package:thimar_driver/features/auth/reset_password/bloc.dart';
import 'package:thimar_driver/features/my_account_screens/about_app/bloc.dart';
import 'package:thimar_driver/features/my_account_screens/contact_us/bloc.dart';
import 'package:thimar_driver/features/my_account_screens/faqs/bloc.dart';
import 'package:thimar_driver/features/my_account_screens/give_advice/bloc.dart';
import 'package:thimar_driver/features/my_account_screens/privacy/bloc.dart';
import 'package:thimar_driver/features/navbar_screens/home/bloc.dart';
import '../../features/auth/logout/bloc.dart';
import 'dio_helper.dart';

void initKiwi() {
  KiwiContainer container = KiwiContainer();
  container.registerSingleton((container) => DioHelper());
  container.registerFactory((c) => LoginBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => ForgetPasswordBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => CheckCodeBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => ResendCodeBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => ResetPasswordBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => LogOutBLoc(c.resolve<DioHelper>()));
  container.registerFactory((c) => AboutAppBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => FAQSBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => GiveAdviceBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => PrivacyBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => ContactUsBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => PendingOrdersBloc(c.resolve<DioHelper>()));
}
