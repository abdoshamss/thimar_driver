import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thimar_driver/core/widgets/toast.dart';

import '../logic/cache_helper.dart';
import '../logic/helper_methods.dart';

class MapItem extends StatefulWidget {
  late double lat;
  late double lng;
  final bool lightMode;

  MapItem({super.key, this.lat = 0, this.lng = 0, this.lightMode = false});

  @override
  State<MapItem> createState() => _State();
}

class _State extends State<MapItem> {
  Set<Marker> markers = {};
  final _controller = Completer<GoogleMapController>();
  late String locationName;
  @override
  void initState() {
    super.initState();
    if (widget.lightMode) {
      goToMyLocation(location: LatLng(widget.lat, widget.lng));
    } else {
      determinePosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        GoogleMap(
          liteModeEnabled: widget.lightMode,
          mapType: MapType.normal,
          markers: markers,
          mapToolbarEnabled: false,
          onTap: (location) async {
            if (!widget.lightMode) {
              await goToMyLocation(location: location);
              await CacheHelper.saveCurrentLocationWithNameMap(locationName);

              await CacheHelper.saveLatAndLng(location);
            } else {
              await getMaps(widget.lat, widget.lng);
            }
          },
          initialCameraPosition:
              CameraPosition(target: LatLng(widget.lat, widget.lng)),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        if (!widget.lightMode)
          GestureDetector(
            onTap: () async {
              determinePosition();

              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 24.h,
              ),
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13.r)),
                child: Icon(
                  Icons.location_on_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 32,
                ),
              ),
            ),
          )
      ],
    );
  }

  Future<void> goToMyLocation({required LatLng location}) async {
    widget.lat = location.latitude;
    widget.lng = location.longitude;

    final GoogleMapController controller = await _controller.future;
    markers.add(Marker(
        markerId: const MarkerId("1"),
        position: LatLng(location.latitude, location.longitude)));
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(zoom: widget.lightMode? 12:14, target: location)));

    getLocation(location.latitude, location.longitude);
    setState(() {});
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission = await Geolocator.requestPermission();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Toast.show("Location services are disabled.", context,
          messageType: MessageType.warning);

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var currentLocation = await Geolocator.getCurrentPosition();

    await goToMyLocation(
        location: LatLng(currentLocation.latitude, currentLocation.longitude));
    print(currentLocation.latitude);
    print(currentLocation.longitude);
    widget.lat = currentLocation.latitude;
    widget.lng = currentLocation.longitude;

    await CacheHelper.saveCurrentLocation(currentLocation);
    getLocation(currentLocation.latitude, currentLocation.longitude);
await CacheHelper.saveLatAndLng(currentLocation);
    return currentLocation;
  }
}

Future<void> getLocation(double lat, double lng) async {
  List<Placemark> placeMarks =
      await placemarkFromCoordinates(lat, lng, localeIdentifier: "EG");
  print(placeMarks.toString());
  print("1" * 80);
  print(placeMarks[0].subAdministrativeArea.toString());
  await CacheHelper.saveCurrentLocationWithNameMap(
      placeMarks[0].locality.toString());
}
