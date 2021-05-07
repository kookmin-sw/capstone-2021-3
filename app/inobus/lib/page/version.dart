import 'package:flutter/material.dart';

class VersionPage extends StatefulWidget {
  VersionPage();
  @override
  _VersionPage createState() => _VersionPage();
}

class _VersionPage extends State<VersionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("라이선스 및 버전"),
        ),
        body: Text('License and version'));
  }
}
