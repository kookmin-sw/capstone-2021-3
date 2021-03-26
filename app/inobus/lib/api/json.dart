import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

List data;
List<String> result = [];

Future<List<String>> requestOrganization() async {
  var jsonText = await rootBundle.loadString('assets/test/organizations.json');
  data = json.decode(jsonText);
  result = [];
  for (int i = 0; i < data.length; i++) {
    result.add(data[i]['name']);
  }
  return result;
}
