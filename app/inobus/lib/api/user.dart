import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:inobus/models/auth_service.dart';
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
  String url =
      "http://ec2-54-149-103-226.us-west-2.compute.amazonaws.com/api/v1/users/" +
          AuthService.user.uid.toString() +
          "/history";
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var responseBody = utf8.decode(response.bodyBytes); //String
    var data = json.decode(responseBody); //json

    for (int i = 0; i < data['history'].length; i++) {
      var date = data['history'].keys.toList()[i];
      var orgInfo = User(date.toString(), data['history'][date].toInt());
      userResult.add(orgInfo);
    }
  } else {
    developer.log("Can not access API");
    developer.log(response.statusCode.toString());
  }

  return userResult;
}
