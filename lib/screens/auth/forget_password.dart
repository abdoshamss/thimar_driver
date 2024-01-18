import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/widgets/pusher.dart';
import 'package:thimar_driver/features/auth/forget_password/bloc.dart';
import 'package:thimar_driver/generated/locale_keys.g.dart';
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
                 LocaleKeys.forget_password_forget_password.tr(),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                    LocaleKeys.forget_password_enter_your_phone_number.tr(),
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
                        return LocaleKeys.log_in_please_enter_your_mobile_number.tr();
                      } else if (value.length < 9) {
                        return LocaleKeys.log_in_please_enter_nine_number.tr();
                      }
                      return null;
                    },
                    controller: _bloc.phoneController,
                    labelText: LocaleKeys.log_in_phone_number.tr(),
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
                            );
                      }
                    },
                    bloc: _bloc,
                    builder: (context, state) => AppButton(
                        isLoading: state is ForgetPasswordLoadingState,
                        text: LocaleKeys.forget_password_confirm_phone_number.tr(),
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
                          text: "${LocaleKeys.forget_password_you_have_an_account.tr()}\t",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => push(const LoginScreen(), ),
                          text: LocaleKeys.my_account_log_in.tr(),
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
