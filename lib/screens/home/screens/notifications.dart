import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
title: const Text("الإشعارات"),
      ),
      body:ListView.separated(
          padding: EdgeInsets.all(16.r),
          itemCount: 5,
          separatorBuilder: (context, index) => SizedBox(
            height: 16.h,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: 6.h,
                start: 10.h,
                end: 10.w,
                top: 11.w,
              ),
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.r,
                      offset: const Offset(0, 5),
                      color: const Color(0x01000000),
                      blurStyle: BlurStyle.outer,spreadRadius: 10.r
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 35.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(.13),
                            borderRadius: BorderRadius.circular(9.r)),
                        child: Padding(
                          padding: EdgeInsets.all(6.0.r),
                          child: Image.network(
                            "https://scontent-hbe1-1.xx.fbcdn.net/v/t39.30808-6/415850344_3661430127405881_2843859566383552217_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=efb6e6&_nc_eui2=AeE4QJcZjWi5gR-m7qrgL1yw8NB-dUn-e_rw0H51Sf57-s6jDCXUEq7VbV_ONQaHtfNsiV1YTOs5TzHxL-68_990&_nc_ohc=tCN3cM8MqI0AX_vH902&_nc_ht=scontent-hbe1-1.xx&oh=00_AfCS2oGRlY4bLLb-xy4soGyw3eh8ryMS5ZbxjKkWv7uJ_w&oe=65A087AA",
                            width: 25.w,
                            height: 25.h,
                            fit: BoxFit.fill,
                            errorBuilder:
                                (context, error, stackTrace) =>
                            const Text("404"),
                          ),
                        )),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "title",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                          "body",
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: const Color(0xff989898)),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                           "createdAt",
                            style: TextStyle(fontSize: 10.sp),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
