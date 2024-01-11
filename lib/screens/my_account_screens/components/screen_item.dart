import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/widgets/pusher.dart';
import 'package:thimar_driver/screens/my_account_screens/edit_profile.dart';

import '../../../gen/assets.gen.dart';

class ScreenItem extends StatelessWidget {
  final String name;
  final String?  icon;
  final Widget? widget;
final Function()? onTap;
final IconData? iconData;
  const ScreenItem(
      {super.key,
      required this.name,  this.icon,
        this.widget,
       this.onTap,   this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.r),
          border: Border.all(color: const Color(0xffF6F6F6)),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap:widget==null?onTap: () {
                push(widget!, c: context);
              },
              child: Padding(
                padding: 
                widget is EditProfileScreen?EdgeInsets.all(16.r):
                EdgeInsets.symmetric(vertical: 16.w),
                child: Row(
                  children: [
                    if(widget!=null)
                    Image.asset(
                      icon!,
                      width: 18.w,
                      height: 18.h,
                    ),
                    if(widget==null)
                      Icon(iconData, color: Theme.of(context).primaryColor,),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      Assets.icons.back.path,
                      width: 18.w,
                      height: 18.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
