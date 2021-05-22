import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:inobus/models/auth_service.dart';
import 'package:inobus/api/api.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  User(
    this.date,
    this.point,
  );
  final String date;
  final int point;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

List<User> userResult = [];

Future<List<User>> requesttUserPointHistory() async {
  String url = ApiUrl().getUserHistoryUrl(AuthService.user.uid.toString());
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final responseBody = utf8.decode(response.bodyBytes); //String
    final data = json.decode(responseBody); //json

    userResult = [];
    for (int i = 0; i < data['history'].length; i++) {
      final date = data['history'].keys.toList()[i];
      final orgInfo = User(date.toString(), data['history'][date].toInt());
      userResult.add(orgInfo);
    }
  } else {
    developer.log("Can not access API");
    developer.log(response.statusCode.toString());
  }

  return userResult;
}
