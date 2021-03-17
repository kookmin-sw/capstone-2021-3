import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'loading.dart';

class MapPage extends StatefulWidget {
  MapPage();
  @override
  _MapPage createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  Completer<GoogleMapController> mapController = Completer();
  Position currentPosition;
  CameraPosition cameraPosition;
  LatLng companyLocation = LatLng(37.60698991689425, 126.9314847979407);

  void locatePosition() async {
    try {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("current locationLatitude: ${currentPosition.latitude}");
      print("current locationLongitude: ${currentPosition.longitude}");
      setState(() {
        cameraPosition = CameraPosition(
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
            zoom: 15);
      });
    } on Exception {
      currentPosition = null;
      print("company locationLatitude: ${companyLocation.latitude}");
      print("company locationLongitude: ${companyLocation.longitude}");
      setState(() {
        cameraPosition = CameraPosition(target: companyLocation, zoom: 15);
      });
    }
  }

  @override
  void initState() {
    locatePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 반응형으로 만들기 위한 변수
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        body: currentPosition != null
            ? Center(
                child: SizedBox(
                    width: mediaQuery.size.width * 0.9,
                    height: mediaQuery.size.height * 0.7,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      initialCameraPosition: cameraPosition,
                      onMapCreated: (GoogleMapController controller) {
                        mapController.complete(controller);
                      },
                    )))
            : LoadingPage());
  }
}
