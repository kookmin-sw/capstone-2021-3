import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

List data;
List<String> result = [];

Future<List<String>> requestOrganization() async {
  result = [];
  String url =
      "http://ec2-54-149-103-226.us-west-2.compute.amazonaws.com/api/v1/organizations/";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var responseBody = utf8.decode(response.bodyBytes); //String
    var data = json.decode(responseBody); //json
    print(data);

    for (int i = 0; i < data.length; i++) {
      result.add(data[i]["name"]);
    }
  } else {
    print("Can not access API");
    print(response.statusCode);
  }
  // 이후 생략되야 하는 코드
  // var jsonText = await rootBundle.loadString('assets/test/organizations.json');
  // print(jsonText.runtimeType);
  // data = json.decode(jsonText);
  // for (int i = 0; i < data.length; i++) {
  //   result.add(data[i]['name']);
  // }
  //
  return result;
}
