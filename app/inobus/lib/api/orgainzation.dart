import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:json_annotation/json_annotation.dart';
import 'package:inobus/api/api.dart';
part 'orgainzation.g.dart';

@JsonSerializable()
class Orgainzation {
  Orgainzation(this.id, this.name, this.point, this.homepage, this.phone);
  final String id;
  final String name;
  final int point;
  final String homepage;
  final String phone;
  factory Orgainzation.fromJson(Map<String, dynamic> json) =>
      _$OrgainzationFromJson(json);
  Map<String, dynamic> toJson() => _$OrgainzationToJson(this);
}

List<Orgainzation> orgResult = [];

Future<List<Orgainzation>> requestOrganization() async {
  orgResult = [];
  String url = ApiUrl().getOrganizationsUrl();
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final responseBody = utf8.decode(response.bodyBytes); //String
    final data = json.decode(responseBody); //json

    orgResult = [];
    for (int i = 0; i < data.length; i++) {
      final orgInfo = Orgainzation.fromJson(data[i]);
      orgResult.add(orgInfo);
    }
  } else {
    developer.log("Can not access API");
    developer.log(response.statusCode.toString());
  }

  return orgResult;
}
