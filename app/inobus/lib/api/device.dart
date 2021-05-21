import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:inobus/api/api.dart';
part 'device.g.dart';

@JsonSerializable()
class Device {
  Device(this.id, this.name, this.model, this.organization, this.install_date,
      this.latitude, this.longitude, this.location_description, this.point);
  final String id;
  final String name;
  final String model;
  final String organization;
  // ignore: non_constant_identifier_names
  final String install_date;
  final double latitude;
  final double longitude;
  // ignore: non_constant_identifier_names
  final String location_description;
  final int point;

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}

List<Marker> allMarkers = [];

Future<List<Marker>> requestDevices() async {
  allMarkers = [];
  String url = ApiUrl().getDevicesUrl();
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var responseBody = utf8.decode(response.bodyBytes); //String
    var data = json.decode(responseBody); //json

    allMarkers = [];
    for (int i = 0; i < data.length; i++) {
      var deviceInfo = Device.fromJson(data[i]);

      allMarkers.add(
        Marker(
          markerId: MarkerId(deviceInfo.name),
          position: LatLng(deviceInfo.latitude, deviceInfo.longitude),
          infoWindow: InfoWindow(
            title: deviceInfo.name,
            snippet: deviceInfo.point.toString() + " Point",
          ),
          draggable: false,
        ),
      );
    }
  } else {
    developer.log("Can not access API");
    developer.log(response.statusCode.toString());
  }

  return allMarkers;
}
