import 'dart:async';
import 'dart:convert';
import 'package:inobus/models/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
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
          AuthService.user.uid;
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var responseBody = utf8.decode(response.bodyBytes); //String
    var data = json.decode(responseBody); //json

    AuthService.point = data["point"];
    for (int i = 0; i < data['누적'].length; i++) {
      var orgInfo = User(data['누적'][i]['date'], data['누적'][i]['point']);
      userResult.add(orgInfo);
    }
  } else {
    print("Can not access API");
    print(response.statusCode);
  }

  return userResult;
}
