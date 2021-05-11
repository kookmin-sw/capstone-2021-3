import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
part 'orgainzation.g.dart';

@JsonSerializable()
class Orgainzation {
  Orgainzation(this.name, this.point);
  final String name;
  final int point;
  factory Orgainzation.fromJson(Map<String, dynamic> json) =>
      _$OrgainzationFromJson(json);
  Map<String, dynamic> toJson() => _$OrgainzationToJson(this);
}

List<Orgainzation> orgResult = [];

Future<List<Orgainzation>> requestOrganization() async {
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
      var ele = Orgainzation(data[i]['name'], data[i]['point']);
      orgResult.add(ele);
    }
  } else {
    print("Can not access API");
    print(response.statusCode);
  }

  return orgResult;
}
