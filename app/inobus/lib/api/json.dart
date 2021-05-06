import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List data;
List<String> result = [];
List<Marker> allMarkers = [];

Future<List<String>> requestOrganization() async {
  var jsonText = await rootBundle.loadString('assets/test/organizations.json');
  data = json.decode(jsonText);
  result = [];
  for (int i = 0; i < data.length; i++) {
    result.add(data[i]['name']);
  }
  return result;
}

Future<List<Marker>> getLocation() async {
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
