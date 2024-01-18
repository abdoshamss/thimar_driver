import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/widgets/app_button.dart';
import 'package:thimar_driver/core/widgets/app_input.dart';
import 'package:thimar_driver/core/widgets/cities_and_car_model.dart';
import 'package:thimar_driver/features/auth/register/bloc.dart';
import 'package:thimar_driver/gen/assets.gen.dart';
import 'package:thimar_driver/screens/auth/check_code.dart';
import 'package:thimar_driver/screens/auth/components/register_part.dart';
import 'package:thimar_driver/screens/auth/components/upload_photo.dart';

import '../../core/logic/helper_methods.dart';
import '../../core/widgets/pusher.dart';
import '../../core/widgets/toast.dart';
import '../../generated/locale_keys.g.dart';
import 'login.dart';

class RegisterCarScreen extends StatefulWidget {
  final String name, phone, location, id, email, password, confirmPassword;

  const RegisterCarScreen(
      {super.key,
      required this.name,
      required this.phone,
      required this.location,
      required this.id,
      required this.email,
      required this.password,
      required this.confirmPassword});

  @override
  State<RegisterCarScreen> createState() => _RegisterCarScreenState();
}

class _RegisterCarScreenState extends State<RegisterCarScreen> {
  bool _isSelectable = false;
  final _formKey = GlobalKey<FormState>();
  final _bloc = KiwiContainer().resolve<RegisterBloc>();

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const RegisterPartScreen(
                isActive: true,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              _bloc.licenseImage = await uploadPhoto(
                                context: context,
                              );
                              setState(() {});
                            },
                            child: PhotoUpload(
                              text: "صورة رخصة القيادة",
                              image: _bloc.licenseImage,
                            )),
                        GestureDetector(
                            onTap: () async {
                              _bloc.carFormImage =
                                  await uploadPhoto(context: context);
                              setState(() {});
                            },
                            child: PhotoUpload(
                              text: "استمارة السيارة",
                              image: _bloc.carFormImage,
                            )),
                        GestureDetector(
                            onTap: () async {
                              _bloc.carInsurance =
                                  await uploadPhoto(context: context);
                              setState(() {});
                            },
                            child: PhotoUpload(
                              text: "تأمين السيارة",
                              image: _bloc.carInsurance,
                            )),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              _bloc.frontCarImage =
                                  await uploadPhoto(context: context);
                              setState(() {});
                            },
                            child: PhotoUpload(
                              text: "السيارة من الأمام",
                              image: _bloc.frontCarImage,
                            )),
                        GestureDetector(
                            onTap: () async {
                              _bloc.behindCarImage =
                                  await uploadPhoto(context: context);
                              setState(() {});
                            },
                            child: PhotoUpload(
                              text: "السيارة من الخلف",
                              image: _bloc.behindCarImage,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              AppInput(
                controller: _bloc.carTypeController,
                labelText: "نوع السيارة",
                prefixIcon: Assets.icons.car.path,
                validator: (value) {
                  if (value.isEmpty) {
                    return "بالرجاء ادخال نوع السيارة";
                  }
                  return null;
                },
              ),
              AppInput(
                controller: _bloc.carModelController,
                labelText: "موديل السيارة",
                prefixIcon: Assets.icons.car.path,
                arrow: true,
                onTap: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(38.r),
                            topRight: Radius.circular(38.r))),
                    context: context,
                    builder: (context) => const Menu(
                      fromWhere: 'Cars',
                    ),
                  ).then((value) {
                    if (value != null) {
                      _bloc.modelId = value[0];
                      _bloc.carModelController.text = value[1];
                    }
                  });
                },
              ),
              AppInput(
                controller: _bloc.ibanNumberController,
                prefixIcon: Assets.icons.ipan.path,
                inputType: InputType.phone,
                saudiIcon: false,
                labelText: "رقم الإيبان",
                validator: (value) {
                  if (value.isEmpty) {
                    return "بالرجاء ادخال رقم الإيبان";
                  }

                  return null;
                },
              ),
              AppInput(
                controller: _bloc.bankNameController,
                labelText: "إسم البنك",
                prefixIcon: Assets.icons.bank.path,
                validator: (value) {
                  if (value.isEmpty) {
                    return "بالرجاء ادخال إسم البنك";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 24.h,
              ),
              GestureDetector(
                onTap: () {
                  _isSelectable = !_isSelectable;
                  setState(() {});
                },
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 18.w,
                      height: 18.h,
                      decoration: BoxDecoration(
                        color: _isSelectable
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                            color: _isSelectable
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).hintColor),
                      ),
                      child: Icon(
                        Icons.check,
                        size: 18,
                        color: _isSelectable
                            ? Colors.white
                            : Theme.of(context).hintColor,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "الموافقة على الشروط والأحكام",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              BlocConsumer(
                bloc: _bloc,
                listener: (BuildContext context, Object? state) {
                  if (state is RegisterSuccessState) {
                    push(
                        CheckCodeScreen(
                            pageName: "activation", phone: widget.phone),
                        );
                  }
                },
                builder: (BuildContext context, state) {
                  return AppButton(
                    isLoading: state is RegisterLoadingState,
                    text: "تسجيل",
                    onPressed: () {
                      String message = "";
                      if (_bloc.licenseImage == null) {
                        message = "بالرجاء ادخال صورة رخصة القيادة";
                      } else if (_bloc.carFormImage == null) {
                        message = "بالرجاء ادخال صورة استمارة السيارة";
                      } else if (_bloc.carInsurance == null) {
                        message = "بالرجاء ادخال صورة تأمين السيارة";
                      } else if (_bloc.frontCarImage == null) {
                        message = "بالرجاء ادخال صورة السيارة من الامام";
                      } else if (_bloc.behindCarImage == null) {
                        message = "بالرجاء ادخال صورة السيارة من الخلف";
                      } else if (_bloc.carModelController.text.isEmpty) {
                        message = "بالرجاء ادخال موديل السيارة";
                      } else if (!_isSelectable) {
                        message = "بالرجاء الموافقة علي الشروط والاحكام";
                      }
                      if (message.isNotEmpty) {
                        Toast.show(message, context,
                            messageType: MessageType.error);
                      } else if (_formKey.currentState!.validate()) {
                        _bloc.add(PostRegisterDataEvent(
                            context: context,
                            name: widget.name,
                            phone: widget.password,
                            location: widget.location,
                            id: widget.id,
                            email: widget.email,
                            password: widget.password,
                            confirmPassword: widget.confirmPassword));
                      }
                      push(
                          CheckCodeScreen(
                              pageName: "activation", phone: widget.phone),
                          );
                    },
                  );
                },
              ),
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
