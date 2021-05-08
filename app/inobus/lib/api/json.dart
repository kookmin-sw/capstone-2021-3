import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

List data;
List<String> orgResult = [];
List<Marker> allMarkers = [];

Future<List<String>> requestOrganization() async {
  orgResult = [];
  String url =
      "http://ec2-54-149-103-226.us-west-2.compute.amazonaws.com/api/v1/organizations/";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var responseBody = utf8.decode(response.bodyBytes); //String
    var data = json.decode(responseBody); //json

    for (int i = 0; i < data.length; i++) {
      orgResult.add(data[i]["name"]);
    }
  } else {
    print("Can not access API");
    print(response.statusCode);
  }

  //이후 생략되야 하는 코드
  var jsonText = await rootBundle.loadString('assets/test/organizations.json');
  var data = json.decode(jsonText);
  orgResult = [];
  for (int i = 0; i < data.length; i++) {
    orgResult.add(data[i]['name']);
    orgResult.add(data[i]['name']);
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
    print("URL 데이터 확인");
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

  // 이후 생략해야 하는 코드
  var jsonText = await rootBundle.loadString('assets/test/location.json');
  var locationList = json.decode(jsonText);
  for (var i = 0; i < locationList.length; i++) {
    String markerId = '${locationList[i]["name"]}';
    String tapString = '${locationList[i]["organization"]}';
    double lat = double.parse('${locationList[i]["latitude"]}');
    double long = double.parse('${locationList[i]["longitude"]}');
    int point = int.parse('${locationList[i]["point"]}');

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

  return allMarkers;
}
