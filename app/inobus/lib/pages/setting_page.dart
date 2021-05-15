import 'package:flutter/material.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/widgets/app_scaffold.dart';
import 'package:inobus/login/google_login.dart';
import 'package:inobus/routes.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    return AppScaffold(
      title: argument.title,
      body: Center(
        child: TextButton(
          onPressed: () {
            logoutGoogle();
            Navigator.pushNamed(context, Routes.intro);
          },
          child: Text(
            "임의 로그아웃",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
