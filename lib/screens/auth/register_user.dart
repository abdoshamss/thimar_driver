import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/logic/cache_helper.dart';
import 'package:thimar_driver/core/widgets/pusher.dart';
import 'package:thimar_driver/core/widgets/app_button.dart';
import 'package:thimar_driver/core/widgets/app_input.dart';
import 'package:thimar_driver/core/widgets/cities_and_car_model.dart';
import 'package:thimar_driver/screens/auth/components/register_part.dart';
import 'package:thimar_driver/screens/auth/login.dart';
import 'package:thimar_driver/screens/auth/map_screen.dart';
import 'package:thimar_driver/screens/auth/register_car.dart';

import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final locationController = TextEditingController();
  final idController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  late int _cityId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const RegisterPartScreen(),
              AppInput(
                controller: nameController,
                prefixIcon: Assets.icons.user.path,
                labelText: "اسم المندوب",
                validator: (value) {
                  if (value.isEmpty) {
                    return "بالرجاء ادخال اسم المندوب";
                  }
                  return null;
                },
              ),
              AppInput(
                controller: phoneController,
                prefixIcon: Assets.icons.phone.path,
                labelText: "رقم الجوال",
                validator: (value) {
                  if (value.isEmpty) {
                    return "بالرجاء ادخال رقم الجوال";
                  } else if (value.length < 9) {
                    return "بالرجاء ادخال ٩ ارقام";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  AppInput(
                      controller: cityController,
                      inputType: InputType.city,
                      prefixIcon: Assets.icons.flag.path,
                      labelText: "المدينة",
                      value: cityController.text,
                      onPressed: () {
                        cityController.text = "";
                        setState(() {

                        });
                      },
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          useSafeArea: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(38.r),
                                  topRight: Radius.circular(38.r))),
                          builder: (context) => const Menu(),
                        ).then((value) {
                          if (value != null) {
                            cityController.text = value[0];
                            _cityId = value[1];
                            setState(() {});
                          }
                        });
                      }),
                ],
              ),
              AppInput(
                controller: locationController,
                prefixIcon: Assets.icons.markRegister.path,
                labelText: "تحديد الموقع على الخريطة",
                onTap: () {
                  push(const MapScreen(), c: context).then((value) {
                    if (CacheHelper.getCurrentLocationWithNameMap()
                        .isNotEmpty) {
                      locationController.text =
                          CacheHelper.getCurrentLocationWithNameMap();
                    }
                  });
                },
              ),
              AppInput(
                controller: idController,
                prefixIcon: Assets.icons.userRegister.path,
                labelText: "رقم الهوية",
                inputType: InputType.phone,
                saudiIcon: false,
                validator: (value) {
                  if (value.isEmpty) {
                    return "بالرجاء ادخال رقم الهوية الخاص بك";
                  }
                  return null;
                },
              ),
              AppInput(
                controller: emailController,
                prefixIcon: Assets.icons.email.path,
                labelText: "البريد الالكتروني",
                validator: (value) {
                  if (value.isEmpty) {
                    return "بالرجاء ادخال البريد الالكتروني الخاص بك";
                  }
                  return null;
                },
              ),
              AppInput(
                controller: passwordController,
                prefixIcon: Assets.icons.password.path,
                labelText: "كلمة المرور",
                inputType: InputType.password,
                validator: (value) {
                  if (value.isEmpty || value.length < 6) {
                    return LocaleKeys.log_in_please_enter_your_password_again
                        .tr();
                  }
                  return null;
                },
              ),
              AppInput(
                controller: confirmPasswordController,
                prefixIcon: Assets.icons.password.path,
                labelText: "تأكيد كلمة المرور",
                inputType: InputType.password,
                validator: (value) {
                  if (value.isEmpty ||
                      value.length < 6 ||
                      value != passwordController.text) {
                    return LocaleKeys.log_in_please_enter_your_password_again
                        .tr();
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.h),
              AppButton(
                  text: "التالي",
                  onPressed: () {
                    push(const RegisterCarScreen(), c: context);
                    if (_formKey.currentState!.validate()) {}
                  }),
              SizedBox(height: 24.h),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            LocaleKeys.forget_password_you_have_an_account.tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => push(const LoginScreen(), c: context),
                        text: LocaleKeys.my_account_log_in.tr(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
