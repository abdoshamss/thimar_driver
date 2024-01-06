import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/widgets/app_input.dart';
import 'package:thimar_driver/core/widgets/cities.dart';

import '../../gen/assets.gen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isActive = false;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          SizedBox(
            height: 16.h,
          ),
          Image.asset(
            Assets.images.logo.path,
            height: 150.h,
            width: 150.w,
          ),
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Text(
              "مرحبا بك مرة أخرى",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Text(
              "يمكنك تسجيل حساب جديد الأن",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(7.r)),
                      child: Center(
                        child: Text(
                          "1",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                ...List.generate(
                    12,
                    (index) => Padding(
                          padding: EdgeInsets.all(1.0.r),
                          child: Container(
                            height: 2.h,
                            width: 8.w,
                            color: isActive
                                ? Theme.of(context).primaryColor
                                : const Color(0xffD7DCD1),
                          ),
                        )),
                Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                      color: isActive
                          ? Theme.of(context).primaryColor
                          : const Color(0xffE4EFD9),
                      borderRadius: BorderRadius.circular(7.r)),
                  child: Center(
                    child: Text(
                      "2",
                      style: TextStyle(
                          color:
                              isActive ? Colors.white : const Color(0xffAAB1A4),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "البيانات الشخصية",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp),
              ),
              Text(
                "بيانات السيارة",
                style: TextStyle(
                    color: isActive
                        ? Theme.of(context).primaryColor
                        : const Color(0xffAAB1A4),
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  AppInput(
                    controller: nameController,
                    prefixIcon: Assets.icons.user.path,
                    labelText: "اسم المندوب",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "بالرجاء ادخال اسم المندوب";
                      }
                      return null;
                    },
                  ),
                  AppInput(
                    controller: phoneController,
                    prefixIcon: Assets.icons.phone.path,
                    labelText: "رقم الجوال",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "بالرجاء ادخال رقم الجوال";
                      } else if (value.length < 9) {
                        return "بالرجاء ادخال ٩ ارقام";
                      }
                      return null;
                    },
                  ),
                ],
              )),
          AppInput(
            controller: cityController,
            prefixIcon: Assets.icons.flag.path,
            enable: false,
            labelText: "المدينة",
            validator: (value) {
              return null;
            },
            onTap: () {
           final result=   showModalBottomSheet(
                context: context,
                builder: (context) => const Cities(),
              );
            },
          ),
        ],
      ),
    );
  }
}
