import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';

List<Marker> allMarkers = [];
List<String> orgResult = [];

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
  for (int i = 0; i < data.length; i++) {
    orgResult.add(data[i]['name']);
  }

  return orgResult;
}

Future<List<Marker>> requestDevices() async {
  allMarkers = [];
  // String url =
  //     "http://ec2-54-149-103-226.us-west-2.compute.amazonaws.com/api/v1/devices/";
  // var response = await http.get(url);
  // if (response.statusCode == 200) {
  //   var responseBody = utf8.decode(response.bodyBytes); //String
  //   var data = json.decode(responseBody); //json
  //   print(data);

  //   for (int i = 0; i < data.length; i++) {
  //     String markerId = '${data[i]["name"]}';
  //     String tapString = '${data[i]["organization"]}';
  //     double lat = double.parse('${data[i]["latitude"]}');
  //     double long = double.parse('${data[i]["longitude"]}');

  //     allMarkers.add(Marker(
  //         markerId: MarkerId(markerId),
  //         draggable: false,
  //         onTap: () {
  //           print(tapString);
  //         },
  //         position: LatLng(lat, long)));
  //   }
  // } else {
  //   print("Can not access API");
  //   print(response.statusCode);
  // }

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

  return allMarkers;
}
