import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../page/loading.dart';
import '../api/json.dart';

class MainMapPage extends StatefulWidget {
  MainMapPage({Key key});
  @override
  _MainMapPage createState() => _MainMapPage();
}

class _MainMapPage extends State<MainMapPage> {
  final Completer<GoogleMapController> mapController = Completer();
  bool loading = true;
  Position currentPosition;
  CameraPosition cameraPosition;
  LatLng companyLocation = LatLng(37.60698991689425, 126.9314847979407);

  List<Marker> allMarkers = [];

  void locatePosition() async {
    try {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        loading = false;
        cameraPosition = CameraPosition(
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
            zoom: 15);
      });
    } on Exception {
      currentPosition = null;
      setState(() {
        loading = false;
        cameraPosition = CameraPosition(target: companyLocation, zoom: 15);
      });
    }

    try {
      allMarkers = await getLocation();
    } on Exception {}
  }

  @override
  void initState() {
    locatePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'INOBUS',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: loading == false
          ? Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: screenWidth,
                    height: screenHeight,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: currentPosition != null ? true : false,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      initialCameraPosition: cameraPosition,
                      markers: Set.from(allMarkers),
                    ),
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.1,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainMapPage()),
                      );
                    },
                    child: Text(
                      "바코드 열기",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff5234eb),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                )
              ],
            )
          : LoadingPage(),
    );
  }
}
