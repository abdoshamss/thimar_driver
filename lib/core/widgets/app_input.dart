import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/gen/assets.gen.dart';

enum InputType { normal, phone, password }

class AppInput extends StatefulWidget {
  final TextEditingController controller;
  final InputType inputType;
  final String prefixIcon;
  final String labelText;
  final bool enable;
  final GestureTapCallback? onTap;
  final FormFieldValidator validator;
  const AppInput(
      {Key? key,
      required this.controller,
      this.inputType = InputType.normal,
      required this.prefixIcon,
      required this.labelText,
      required this.validator,
      this.enable = true,
      this.onTap})
      : super(key: key);

  @override
  State<AppInput> createState() => _AppInputState();
}

bool _isShow = true;

class _AppInputState extends State<AppInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          if (widget.inputType == InputType.phone)
            Container(
              width: 70.w,
              height: 60.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: const Color(0xffF3F3F3))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 35.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.images.saudi.path),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "966+",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          SizedBox(
            width: 8.w,
          ),
          SizedBox(
            width: widget.inputType == InputType.phone ? 265.w : 335.w,
            child: TextFormField(
              enabled: widget.enable,
              onTap: widget.onTap,
              validator: widget.validator,
              controller: widget.controller,
              keyboardType: widget.inputType == InputType.phone
                  ? TextInputType.phone
                  : TextInputType.text,
              inputFormatters: widget.inputType == InputType.phone
                  ? [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))]
                  : [],
              decoration: InputDecoration(
                  suffixIcon: widget.inputType == InputType.password
                      ? GestureDetector(
                          onTap: () {
                            _isShow = !_isShow;
                            setState(() {});
                          },
                          child: Icon(_isShow
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded),
                        )
                      : null,
                  prefixIcon: Image.asset(widget.prefixIcon),
                  labelText: widget.labelText,
                  labelStyle: const TextStyle(color: Color(0xffB1B1B1))),
              obscureText: !_isShow && widget.inputType == InputType.password,
            ),
          ),
        ],
      ),
    );
  }
}
