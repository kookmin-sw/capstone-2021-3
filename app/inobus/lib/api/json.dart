import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class OrgEle {
  String name;
  int point;
}

List<OrgEle> orgResult = [];
List<Marker> allMarkers = [];

Future<List<OrgEle>> requestOrganization() async {
  orgResult = [];
  String url =
      "http://ec2-54-149-103-226.us-west-2.compute.amazonaws.com/api/v1/organizations/";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var responseBody = utf8.decode(response.bodyBytes); //String
    var data = json.decode(responseBody);
    print("기관 URL 데이터 확인");
    print(data); //json

    for (int i = 0; i < data.length; i++) {
      var ele = OrgEle();
      ele.name = data[i]['name'];
      ele.point = data[i]['point'];
      orgResult.add(ele);
    }
  } else {
    print("Can not access API");
    print(response.statusCode);
  }

  return orgResult;
}

Future<List<Marker>> requestDevices() async {
  allMarkers = [];
  String url =
      "http://ec2-54-149-103-226.us-west-2.compute.amazonaws.com/api/v1/devices/";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var responseBody = utf8.decode(response.bodyBytes); //String
    var data = json.decode(responseBody); //json
    print("지도 URL 데이터 확인");
    print(data);

    for (int i = 0; i < data.length; i++) {
      String markerId = '${data[i]["name"]}';
      String tapString = '${data[i]["organization"]}';
      double lat = double.parse('${data[i]["latitude"]}');
      double long = double.parse('${data[i]["longitude"]}');
      int point = int.parse('${data[i]["point"]}');

      allMarkers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(
              title: "속한 기관 명 : " + tapString,
              snippet: point.toString() + " Point"),
          draggable: false,
        ),
      );
    }
  } else {
    print("Can not access API");
    print(response.statusCode);
  }

  return allMarkers;
}
