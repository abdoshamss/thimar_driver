import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/widgets/pusher.dart';
import 'package:thimar_driver/features/auth/forget_password/bloc.dart';
import 'package:thimar_driver/screens/auth/check_code.dart';
import 'package:thimar_driver/screens/auth/login.dart';

import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_input.dart';
import '../../gen/assets.gen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bloc = KiwiContainer().resolve<ForgetPasswordBloc>();
  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            SizedBox(
              height: 16.h,
            ),
            Image.asset(
              Assets.images.logo.path,
              height: 150.h,
              width: 150.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "نسيت كلمة المرور",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "أدخل رقم الجوال المرتبط بحسابك",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 27.h,
                ),
                Form(
                  key: _formKey,
                  child: AppInput(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "بالرجاء ادخال رقم هاتفك";
                      } else if (value.length < 9) {
                        return "بالرجاء ادخال ٩ ارقام";
                      }
                      return null;
                    },
                    controller: _bloc.phoneController,
                    labelText: "رقم الجوال",
                    inputType: InputType.phone,
                    prefixIcon: Assets.icons.phone.path,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                BlocConsumer(
                    listener: (context, state) {
                      if (state is ForgetPasswordSuccessState) {
                        push(
                            CheckCodeScreen(
                              pageName: 'check',
                              phone: _bloc.phoneController.text,
                            ),
                            c: context);
                      }
                    },
                    bloc: _bloc,
                    builder: (context, state) => AppButton(
                        isLoading: state is ForgetPasswordLoadingState,
                        text: "تأكيد رقم الجوال",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _bloc.add(
                                PostForgetPasswordDataEvent(context: context));
                          }
                        })),
                SizedBox(
                  height: 48.h,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: "لديك حساب بالفعل؟\t",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => push(const LoginScreen(), c: context),
                          text: "تسجيل الدخول",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
