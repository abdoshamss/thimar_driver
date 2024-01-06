import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';

enum ButtonType { elevated, outline, cancel }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType buttonType;
  final bool isLoading;
  bool isBig;
  AppButton(
      {Key? key,
      required this.text,
      this.onPressed,
      this.buttonType = ButtonType.elevated,
      this.isBig = true,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading?loadingWidget(): Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: const Color(0x1361B80C).withOpacity(.19),
              blurRadius: 6,
              offset: const Offset(0, 3),
              blurStyle: BlurStyle.outer),
        ]),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : buttonType == ButtonType.elevated
                ? ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      fixedSize: isBig ? Size(343.w, 60.h) : Size(135.h, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800),
                    ),
                  )
                : OutlinedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonType == ButtonType.cancel
                          ? const Color(0xffFFE1E1)
                          : null,
                      elevation: 0,
                      foregroundColor: buttonType == ButtonType.cancel
                          ? const Color(0xffFF0000)
                          : null,
                      fixedSize: isBig ? Size(343.w, 60.h) : Size(135.h, 50.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.r),
                      child: Text(
                        text,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                    ),
                  ));
  }
}
