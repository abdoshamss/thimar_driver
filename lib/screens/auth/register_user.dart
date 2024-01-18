import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/logic/cache_helper.dart';
import 'package:thimar_driver/core/widgets/pusher.dart';
import 'package:thimar_driver/core/widgets/app_button.dart';
import 'package:thimar_driver/core/widgets/app_input.dart';
import 'package:thimar_driver/core/widgets/cities_and_car_model.dart';
import 'package:thimar_driver/core/widgets/toast.dart';
import 'package:thimar_driver/screens/auth/components/register_part.dart';
import 'package:thimar_driver/screens/auth/login.dart';
import 'package:thimar_driver/screens/auth/map_screen.dart';
import 'package:thimar_driver/screens/auth/register_car.dart';

import '../../features/auth/register/bloc.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _cityController = TextEditingController();
  final _bloc = KiwiContainer().resolve<RegisterBloc>();
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
                controller: _nameController,
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
                controller: _phoneController,
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
                      controller: _cityController,
                      inputType: InputType.city,
                      prefixIcon: Assets.icons.flag.path,
                      labelText: "المدينة",
                      value: _cityController.text,
                      onPressed: () {
                        _cityController.text = "";
                        setState(() {});
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
                            _bloc.cityId = value[0];
                            _cityController.text = value[1];
                            setState(() {});
                          }
                        });
                      }),
                ],
              ),
              AppInput(
                controller: _locationController,
                prefixIcon: Assets.icons.markRegister.path,
                labelText: "تحديد الموقع على الخريطة",
                onTap: () {
                  push(const MapScreen(), ).then((value) {
                    if (CacheHelper.getCurrentLocationWithNameMap()
                        .isNotEmpty) {
                      _locationController.text =
                          CacheHelper.getCurrentLocationWithNameMap();
                    }
                  });
                },
              ),
              AppInput(
                controller: _idController,
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
                controller: _emailController,
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
                controller: _passwordController,
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
                controller: _confirmPasswordController,
                prefixIcon: Assets.icons.password.path,
                labelText: "تأكيد كلمة المرور",
                inputType: InputType.password,
                validator: (value) {
                  if (value.isEmpty ||
                      value.length < 6 ||
                      value != _passwordController.text) {
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
                    if (_cityController.text.isEmpty) {
                      Toast.show("بالرجاء ادخال المدينة", context,
                          messageType: MessageType.error);
                    } else if (_locationController.text.isEmpty) {
                      Toast.show("بالرجاء ادخال العنوان علي الخريطة", context,
                          messageType: MessageType.error);
                    } else if (_formKey.currentState!.validate()) {
                      push(
                          RegisterCarScreen(
                            name: _nameController.text,
                            phone: _phoneController.text,
                            location: _locationController.text,
                            id: _idController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
                          ),
                          );
                    }
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
                          ..onTap = () => push(const LoginScreen(), ),
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
