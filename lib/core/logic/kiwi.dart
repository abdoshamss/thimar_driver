import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/features/auth/check_code/bloc.dart';
import 'package:thimar_driver/features/auth/edit_password/bloc.dart';
import 'package:thimar_driver/features/auth/forget_password/bloc.dart';
import 'package:thimar_driver/features/auth/login/bloc.dart';
import 'package:thimar_driver/features/auth/register/bloc.dart';
import 'package:thimar_driver/features/auth/resend_code/bloc.dart';
import 'package:thimar_driver/features/auth/reset_password/bloc.dart';
import 'package:thimar_driver/features/components/cities/bloc.dart';
import 'package:thimar_driver/features/my_account_screens/about_app/bloc.dart';
import 'package:thimar_driver/features/my_account_screens/contact_us/bloc.dart';
import 'package:thimar_driver/features/my_account_screens/faqs/bloc.dart';
import 'package:thimar_driver/features/my_account_screens/give_advice/bloc.dart';
import 'package:thimar_driver/features/my_account_screens/privacy/bloc.dart';
 import 'package:thimar_driver/features/navbar_screens/home/bloc.dart';
import 'package:thimar_driver/features/navbar_screens/my_orders/accept_order/bloc.dart';
import 'package:thimar_driver/features/navbar_screens/my_orders/finished/bloc.dart';
import 'package:thimar_driver/features/navbar_screens/my_orders/refuse_order/bloc.dart';
import 'package:thimar_driver/features/navbar_screens/my_orders/start_delivering/bloc.dart';
import 'package:thimar_driver/features/navbar_screens/noifications/bloc.dart';
import 'package:thimar_driver/features/order_details/bloc.dart';
import 'package:thimar_driver/features/profile/edit_profile/bloc.dart';
import 'package:thimar_driver/features/profile/get_profile/bloc.dart';
import '../../features/auth/logout/bloc.dart';
 import '../../features/navbar_screens/my_orders/current/bloc.dart';
import '../../features/navbar_screens/my_orders/end_order/bloc.dart';
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
  container.registerFactory((c) => RegisterBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => OrderDetailsBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) =>  GetProfileBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => CurrentOrdersBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => FinishedOrdersBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => NotificationsBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => AcceptOrderBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => RefuseOrderBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => StartDeliveringBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => EndOrderBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => EditPasswordBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => CitiesBloc(c.resolve<DioHelper>()));
  container.registerFactory((c) => EditProfileBloc(c.resolve<DioHelper>()));
}
