import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thimar_driver/core/widgets/app_button.dart';
import 'package:thimar_driver/core/widgets/app_input.dart';
import 'package:thimar_driver/core/widgets/cities_and_car_model.dart';
import 'package:thimar_driver/gen/assets.gen.dart';
import 'package:thimar_driver/screens/auth/components/register_part.dart';
import 'package:thimar_driver/screens/auth/components/upload_photo.dart';

import '../../core/widgets/pusher.dart';
import '../../generated/locale_keys.g.dart';
import 'login.dart';

class RegisterCarScreen extends StatefulWidget {
  const RegisterCarScreen({super.key});

  @override
  State<RegisterCarScreen> createState() => _RegisterCarScreenState();
}

class _RegisterCarScreenState extends State<RegisterCarScreen> {
  final _formKey = GlobalKey<FormState>();

  final carTypeController = TextEditingController();
  final carModelController = TextEditingController();
  final bankNameController = TextEditingController();
  final ibanNumberController = TextEditingController();

  File? _licenseImage,
      _carFormImage,
      _carInsurance,
      _frontCarImage,
      _behindCarImage;
  bool _isSelectable = false;
  late int _modelId;

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
                              _licenseImage = await _uploadPhoto(
                                context: context,
                              );
                              setState(() {});
                            },
                            child:
                                  PhotoUpload(text: "صورة رخصة القيادة", image: _licenseImage,)),
                        GestureDetector(
                            onTap: () async {
                              _carFormImage =
                                  await _uploadPhoto(context: context);   setState(() {});
                            },
                            child:   PhotoUpload(text: "استمارة السيارة", image: _carFormImage,)),
                        GestureDetector(
                            onTap: () async {
                              _carInsurance =
                                  await _uploadPhoto(context: context);   setState(() {});
                            },
                            child:   PhotoUpload(text: "تأمين السيارة", image: _carInsurance,)),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              _frontCarImage =
                                  await _uploadPhoto(context: context);   setState(() {});
                            },
                            child:
                                  PhotoUpload(text: "السيارة من الأمام", image: _frontCarImage,)),
                        GestureDetector(
                            onTap: () async {
                              _behindCarImage =
                                  await _uploadPhoto(context: context);   setState(() {});
                            },
                            child:   PhotoUpload(text: "السيارة من الخلف", image: _behindCarImage,)),
                      ],
                    ),
                  ],
                ),
              ),
              AppInput(
                controller: carTypeController,
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
                controller:carModelController ,
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
                    carModelController.text = value[0];
                    _modelId = value[1];
                  });
                },
              ),
              AppInput(
                controller: ibanNumberController,
                prefixIcon: Assets.icons.ipan.path,
                inputType: InputType.phone,
                saudiIcon: false,
                labelText: "رقم الإيبان",
              ),
              AppInput(
                controller: bankNameController,
                labelText: "إسم البنك",
                prefixIcon: Assets.icons.bank.path,
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
              AppButton(
                text: "تسجيل",
                onPressed: () {},
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

  Future<File> _uploadPhoto({required BuildContext context, File? image}) async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(38.r), topRight: Radius.circular(38.r))),
      builder: (context) => Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close)),
                  Text(
                    LocaleKeys.profile_select_image_from.tr(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 32.r,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final image2 = await ImagePicker.platform.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 30,
                      );
                      if (image2 != null) {
                        image = File(image2.path);
                        debugPrint(image2.path);
                        Navigator.pop(context);
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.image_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(LocaleKeys.profile_gallery.tr()),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final image2 = await ImagePicker.platform.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 30,
                      );
                      if (image2 != null) {
                        image = File(image2.path);
                        debugPrint(image2.path);
                        Navigator.pop(context);
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(LocaleKeys.profile_camera.tr()),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return image!;
  }
}
