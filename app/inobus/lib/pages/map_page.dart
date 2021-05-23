import 'dart:async';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/routes.dart';
import 'package:inobus/app_images.dart';
import 'package:inobus/api/device.dart';
import 'package:inobus/widgets/app_scaffold.dart';
import 'package:inobus/widgets/circle_button.dart';
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
      allMarkers = await requestDevices();
    } on Exception {}
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppScaffold(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text('뒤로 가기를 1번 더 누르면 종료 됩니다.'),
        ),
        child: FutureBuilder(
        future: locatePosition(),
        builder: (context, snapshot) {
          developer.log(snapshot.connectionState.toString());
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
                      child: RoundedRectangleBorderButton(
                        padding: 15,
                        radius: 30,
                        backgroudColor: AppColors.primary,
                        textColor: Colors.white,
                        onPressed: () {
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
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
