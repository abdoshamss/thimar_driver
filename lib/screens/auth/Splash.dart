import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/logic/cache_helper.dart';
import 'package:thimar_driver/core/widgets/pusher.dart';
import 'package:thimar_driver/gen/assets.gen.dart';
import 'package:thimar_driver/screens/auth/login.dart';
import 'package:thimar_driver/screens/home/view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (CacheHelper.getToken() == null) {
        push(const LoginScreen(), );
      } else {
        pushAndRemoveUntil(HomeNavBarScreen(), );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width.w,
        height: MediaQuery.of(context).size.height.h,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.images.splashBackground.path),
                fit: BoxFit.cover)),
        child: Center(
          child: SizedBox(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.asset(
                  Assets.images.mainLogo.path,
                  width: 160.w,
                ),
                Positioned(
                    top: -1,
                    right: 60,
                    child: BounceInDown(
                        child: Image.asset(Assets.images.topLeaves.path))),
                Positioned(
                    bottom: 5,
                    child: FlipInY(
                        child: Image.asset(Assets.images.sideLeaves.path)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
