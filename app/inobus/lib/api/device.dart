import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
part 'device.g.dart';

@JsonSerializable()
class Device {
  Device(this.name, this.id, this.organ, this.installDate, this.point, this.lat,
      this.long, this.loc);
  final String name;
  final String id;
  final String organ;
  final String installDate;
  final int point;
  final double lat;
  final double long;
  final String loc;

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}

List<Marker> allMarkers = [];

Future<List<Marker>> requestDevices() async {
  allMarkers = [];
  String url =
      "http://ec2-54-149-103-226.us-west-2.compute.amazonaws.com/api/v1/devices/";
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var responseBody = utf8.decode(response.bodyBytes); //String
    var data = json.decode(responseBody); //json

    for (int i = 0; i < data.length; i++) {
      var deviceInfo = Device(
          data[i]["name"],
          data[i]["_id"],
          data[i]["organization"],
          data[i]["install_date"],
          data[i]["point"],
          data[i]["latitude"],
          data[i]["longitude"],
          data[i]["location_description"]);

      allMarkers.add(
        Marker(
          markerId: MarkerId(deviceInfo.name),
          position: LatLng(deviceInfo.lat, deviceInfo.long),
          infoWindow: InfoWindow(
            title: "속한 기관 명 : " + deviceInfo.organ,
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
