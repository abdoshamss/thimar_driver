import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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

