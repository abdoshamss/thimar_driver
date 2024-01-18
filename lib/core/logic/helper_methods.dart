import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../generated/locale_keys.g.dart';

Widget loadingWidget() => const Center(
      child: CircularProgressIndicator(),
    );

Widget noInternet() => Center(
      child: Text(LocaleKeys.no_internet.tr()),
    );
Future<void> getMaps(double lat, double lng) async {
  final availableMaps = await MapLauncher.installedMaps;
  print(availableMaps);
  if (await MapLauncher.isMapAvailable(MapType.google) ?? false) {
    await availableMaps.first.showMarker(
      coords: Coords(lat, lng),
      title: "test",
    );
  }
}

Future<File> uploadPhoto({required BuildContext context, File? image}) async {
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