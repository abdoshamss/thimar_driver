import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thimar_driver/core/widgets/app_button.dart';
import 'package:thimar_driver/core/widgets/custom_appbar.dart';
import 'package:thimar_driver/core/widgets/map.dart';
import 'package:thimar_driver/generated/locale_keys.g.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   CustomAppBar(
        text: LocaleKeys.register_locate_position.tr(),
      ),
      body: Stack(alignment: const Alignment(0, .9), children: [
        MapItem(lat: 0, lng: 0),
        AppButton(
          text: LocaleKeys.confirm.tr(),
          isBig: false,
          onPressed: () {Navigator.pop(context);},
        )
      ]),
    );
  }
}
