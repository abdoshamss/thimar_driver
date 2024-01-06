import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/logic/kiwi.dart';
import 'package:thimar_driver/core/res/color.dart';
import 'package:thimar_driver/core/res/theme.dart';
import 'package:thimar_driver/core/widgets/un_focus.dart';
import 'package:thimar_driver/firebase_options.dart';
import 'package:thimar_driver/screens/auth/Splash.dart';

import 'core/logic/cache_helper.dart';

import 'generated/codegen_loader.g.dart';

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.getToken().then((value) {
    print("My Fcm Token Is");
    print(value.toString());
  });
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: getMaterialColor(primaryColor.value),
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  initKiwi();
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        saveLocale: true,
        startLocale: const Locale('ar'),
        path: 'assets/translations',
        assetLoader: const CodegenLoader(),
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => child!,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        key: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Thimar',
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.sp),
              child: UnFocus(
                child: Directionality(
                    textDirection: mat.TextDirection.rtl , child: child!),
              ));
        },
        theme: theme,
        home: const SplashScreen(),
      ),
    );
  }
}
