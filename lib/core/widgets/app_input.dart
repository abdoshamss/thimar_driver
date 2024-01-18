import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/gen/assets.gen.dart';

enum InputType { normal, phone, password, search, city }

class AppInput extends StatefulWidget {
  final TextEditingController? controller;
  final InputType inputType;
  final String? prefixIcon, labelText, hintText,value;

  final bool saudiIcon;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final VoidCallback? onPressed;

  final FormFieldValidator? validator;
  final TextInputAction? textInputAction;
  final bool backgroundColor, arrow;
  final int maxLines;

  const AppInput({
    super.key,
      this.controller,
    this.inputType = InputType.normal,
    this.prefixIcon,
    this.validator,
    this.labelText,
    this.hintText,
    this.onTap,
    this.onChanged,
    this.textInputAction,
    this.backgroundColor = false,
    this.saudiIcon = true,
    this.onPressed,
    this.value,
    this.maxLines = 1,
    this.arrow = false,
  });

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
          if (widget.inputType == InputType.phone && widget.saudiIcon)
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
                    width: 30.w,
                    height: 18.h,
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

                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          SizedBox(
            width: 8.w,
          ),
          SizedBox(
            width: widget.inputType == InputType.city&& widget.value!.isNotEmpty
                ? 275.w
                : widget.inputType == InputType.phone && widget.saudiIcon
                    ? 265.w
                    : 335.w,
            child: TextFormField(
              onChanged: widget.onChanged,
              readOnly: widget.onTap != null,
              onTap: widget.onTap,
              validator: widget.validator,
              maxLines: widget.maxLines,
              controller: widget.controller,
              textInputAction: widget.textInputAction,
              keyboardType: widget.inputType == InputType.phone
                  ? TextInputType.phone
                  : TextInputType.text,
              inputFormatters: widget.inputType == InputType.phone
                  ? [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))]
                  : [],
              decoration: InputDecoration(
                  filled: true,
                  fillColor: widget.inputType == InputType.search ||
                          widget.backgroundColor
                      ? const Color(0xffFAFFF5)
                      : Colors.white,
                  suffixIcon: widget.arrow
                      ?   Icon(Icons.arrow_back_ios_new_outlined,color: Theme.of(context).primaryColor,size: 15,)
                      : widget.inputType == InputType.password
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
                  prefixIcon: widget.prefixIcon != null
                      ? Image.asset(widget.prefixIcon!)
                      : null,
                  labelText: widget.labelText,
                  hintText: widget.hintText,
                  labelStyle: const TextStyle(color: Color(0xffB1B1B1))),
              obscureText: !_isShow && widget.inputType == InputType.password,
            ),
          ),
          if (widget.inputType == InputType.city&& widget.value!.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: IconButton(
                  onPressed: widget.onPressed,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 26,
                  )),
            ),
        ],
      ),
    );
  }
}
