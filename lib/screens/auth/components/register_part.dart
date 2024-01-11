import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';

class RegisterPartScreen extends StatelessWidget {
  final bool isActive;
  const RegisterPartScreen({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              GestureDetector(
                onTap: () {
                  if (isActive) {
                    Navigator.pop(context);
                  }
                },
                child: Column(
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
      ],
    );
  }
}
