import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'loading.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class MapPage extends StatefulWidget {
  MapPage();
  @override
  _MapPage createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  final Completer<GoogleMapController> mapController = Completer();
  bool loading = true;
  Position currentPosition;
  CameraPosition cameraPosition;
  LatLng companyLocation = LatLng(37.60698991689425, 126.9314847979407);

  List<Marker> allMarkers = [];

  void getLocation() async {
    var jsonText = await rootBundle.loadString('assets/test/location.json');
    var locationList = json.decode(jsonText);
    for (var i = 0; i < locationList.length; i++) {
      String markerId = '${locationList[i]["name"]}';
      String tapString = '${locationList[i]["organization"]}';
      double lat = double.parse('${locationList[i]["latitude"]}');
      double long = double.parse('${locationList[i]["longitude"]}');

      allMarkers.add(Marker(
          markerId: MarkerId(markerId),
          draggable: false,
          onTap: () {
            print(tapString);
          },
          position: LatLng(lat, long)));
    }
    setState(() {});
  }

  void locatePosition() async {
    try {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      developer.log("current latitude: ${currentPosition.latitude}");
      developer.log("current longitude: ${currentPosition.longitude}");
      setState(() {
        loading = false;
        cameraPosition = CameraPosition(
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
            zoom: 15);
      });
    } on Exception {
      currentPosition = null;
      developer.log("companyLocation latitude: ${companyLocation.latitude}");
      developer.log("companyLocation longitude: ${companyLocation.longitude}");
      setState(() {
        loading = false;
        cameraPosition = CameraPosition(target: companyLocation, zoom: 15);
      });
    }
  }

  @override
  void initState() {
    locatePosition();
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 반응형으로 만들기 위한 변수
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        body: loading == false
            ? Center(
                child: SizedBox(
                    width: mediaQuery.size.width * 0.9,
                    height: mediaQuery.size.height * 0.7,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: currentPosition != null ? true : false,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      initialCameraPosition: cameraPosition,
                      markers: Set.from(allMarkers),
                      onMapCreated: (GoogleMapController controller) {
                        mapController.complete(controller);
                      },
                      // pageView 가로 제스쳐 겹지치 않게 만들기
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                        new Factory<OneSequenceGestureRecognizer>(
                          () => new EagerGestureRecognizer(),
                        ),
                      ].toSet(),
                    )))
            : LoadingPage());
  }
}
