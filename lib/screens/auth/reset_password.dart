import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/logic/pusher.dart';
import 'package:thimar_driver/core/widgets/app_input.dart';
import 'package:thimar_driver/features/auth/reset_password/bloc.dart';

import '../../core/widgets/app_button.dart';
import '../../gen/assets.gen.dart';
import 'login.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String phone, code;
  const ResetPasswordScreen({Key? key, required this.phone, required this.code})
      : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bloc = KiwiContainer().resolve<ResetPasswordBloc>();
  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
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
                  "أدخل كلمة المرور الجديدة",
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppInput(
                          controller: _bloc.newPasswordController,
                          prefixIcon: Assets.icons.password.path,
                          labelText: "كلمة المرور الجديدة",
                          inputType: InputType.password,
                          validator: (value) {
                            if (value.isEmpty || value.length < 6) {
                              return "بالرجاء ادخال كلمة المرور الجديدة ستة احرف علي الاقل";
                            }
                            return null;
                          },
                        ),
                        AppInput(
                          controller: _bloc.confirmNewPasswordController,
                          prefixIcon: Assets.icons.password.path,
                          labelText: "كلمة المرور الجديدة",
                          inputType: InputType.password,
                          validator: (value) {
                            if (value.isEmpty || value.length < 6) {
                              return "بالرجاء ادخال كلمة المرور الجديدة ستة احرف علي الاقل";
                            }
                            return null;
                          },
                        )
                      ],
                    )),
                SizedBox(
                  height: 8.h,
                ),
                BlocBuilder(
                    bloc: _bloc,
                    builder: (context, state) => AppButton(
                        isLoading: state is ResetPasswordLoadingState,
                        text: "تغيير كلمة المرور",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _bloc.add(PostResetPasswordDataEvent(
                                phone: widget.phone,
                                code: widget.code,
                                context: context));
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
