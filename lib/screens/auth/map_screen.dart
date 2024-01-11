import 'package:flutter/material.dart';
import 'package:thimar_driver/core/widgets/app_button.dart';
import 'package:thimar_driver/core/widgets/custom_appbar.dart';
import 'package:thimar_driver/core/widgets/map.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        text: "تحديد الموقع على الخريطة",
      ),
      body: Stack(alignment: Alignment(0, .9), children: [
        MapItem(lat: 0, lng: 0),
        AppButton(
          text: "تأكيد",
          isBig: false,
          onPressed: () {Navigator.pop(context);},
        )
      ]),
    );
  }
}
