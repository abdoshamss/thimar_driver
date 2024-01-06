import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/logic/pusher.dart';
import 'package:thimar_driver/core/res/color.dart';
import 'package:thimar_driver/core/widgets/app_button.dart';
import 'package:thimar_driver/core/widgets/app_input.dart';
import 'package:thimar_driver/features/auth/login/bloc.dart';
import 'package:thimar_driver/screens/auth/forget_password.dart';
import 'package:thimar_driver/screens/auth/register.dart';

import '../../gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bloc = KiwiContainer().resolve<LoginBloc>();
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
                GestureDetector(
                  onTap: () {
                    push(const RegisterScreen());
                  },
                  child: Text(
                    "مرحبا بك مرة أخرى",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "يمكنك تسجيل الدخول الأن",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: hintTextColor),
                ),
                SizedBox(
                  height: 27.h,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppInput(
                        controller: _bloc.phoneController,
                        inputType: InputType.phone,
                        prefixIcon: Assets.icons.phone.path,
                        labelText: "رقم الجوال",
                        validator: (value) {
                          if (value.isEmpty) {
                            return "بالرجاء ادخال رقم هاتفك";
                          } else if (value.length < 9) {
                            return "بالرجاء ادخال ٩ ارقام";
                          }
                          return null;
                        },
                      ),
                      AppInput(
                        controller: _bloc.passwordController,
                        inputType: InputType.password,
                        prefixIcon: Assets.icons.password.path,
                        labelText: "كلمة المرور",
                        validator: (value) {
                          if (value.isEmpty) {
                            return "بالرجاء ادخال كلمة المرور";
                          } else if (value.length < 8) {
                            return "بالرجاء ادخال ٨ احرف علي الاقل";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: GestureDetector(
                    onTap: () {
                      push(const ForgetPasswordScreen(), c: context);
                    },
                    child: Text(
                      "نسيت كلمة المرور ؟",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                BlocBuilder(
                  bloc: _bloc,
                  builder: (context, state) => AppButton(
                    isLoading: state is LoginLoadingState,
                    text: 'تسجيل الدخول',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _bloc.add(PostLoginDataEvent(context: context));
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 48.h,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: "ليس لديك حساب؟\t",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => push(const RegisterScreen(), c: context),
                          text: "تسجيل الأن",
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
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
