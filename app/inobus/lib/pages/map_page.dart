import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inobus/api/json.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/routes.dart';
import 'package:inobus/app_images.dart';
import 'package:inobus/widgets/app_scaffold.dart';
import 'package:inobus/models/route_argument.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final Completer<GoogleMapController> mapController = Completer();

  Position currentPosition;

  CameraPosition cameraPosition;

  final companyLocation = LatLng(37.60698991689425, 126.9314847979407);

  List<Marker> allMarkers = [];

  Future<void> locatePosition() async {
    try {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      cameraPosition = CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 15);
    } on Exception {
      currentPosition = null;
      cameraPosition = CameraPosition(target: companyLocation, zoom: 15);
    }
    try {
      allMarkers = await getLocation();
    } on Exception {}
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppScaffold(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      body: FutureBuilder(
        future: locatePosition(),
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.done) {
            final screenSize = MediaQuery.of(context).size;
            final screenHeight = screenSize.height;

            return Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: currentPosition != null ? true : false,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    initialCameraPosition: cameraPosition,
                    markers: Set.from(allMarkers),
                  ),
                  Positioned(
                    bottom: screenHeight * 0.1,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, Routes.barcode,
                            arguments: RouteArgument(title: "바코드 열기"));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            child: AppImages.barcode.image(),
                          ),
                          Text(
                            "바코드 열기",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        primary: AppColors.primary,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
