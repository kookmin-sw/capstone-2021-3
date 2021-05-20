import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:json_annotation/json_annotation.dart';
part 'orgainzation.g.dart';

@JsonSerializable()
class Orgainzation {
  Orgainzation(this.name, this.point, this.phone, this.url, this.id);
  final String name;
  final int point;
  final String phone;
  final String url;
  final String id;
  factory Orgainzation.fromJson(Map<String, dynamic> json) =>
      _$OrgainzationFromJson(json);
  Map<String, dynamic> toJson() => _$OrgainzationToJson(this);
}

List<Orgainzation> orgResult = [];

Future<List<Orgainzation>> requestOrganization() async {
  orgResult = [];
  String url =
      "http://ec2-54-149-103-226.us-west-2.compute.amazonaws.com/api/v1/organizations/";
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var responseBody = utf8.decode(response.bodyBytes); //String
    var data = json.decode(responseBody); //json

    for (int i = 0; i < data.length; i++) {
      var orgInfo = Orgainzation(data[i]['name'], data[i]['point'],
          data[i]['phone'], data[i]['homepage'], data[i]['_id']);
      orgResult.add(orgInfo);
    }
  } else {
    developer.log("Can not access API");
    developer.log(response.statusCode.toString());
  }

  return orgResult;
}
