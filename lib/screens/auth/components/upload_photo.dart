import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thimar_driver/gen/assets.gen.dart';

import '../../../generated/locale_keys.g.dart';

class PhotoUpload extends StatelessWidget {
  final String text;
 final File? image;
  const PhotoUpload({super.key, required this.text,required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80.w,
          height: 70.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(
                  image: image == null
                      ? AssetImage(Assets.images.uploadPhoto.path)
                          as ImageProvider
                      : FileImage(image!),
                  fit: BoxFit.fill)),
        ),
        SizedBox(height: 8.h),
        Text(
          text,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
