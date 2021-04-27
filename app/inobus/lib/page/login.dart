import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage();
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("로그인"),
      ),
      body: Text('Log in'),
    );
  }
}
