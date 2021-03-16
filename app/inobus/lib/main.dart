import 'package:flutter/material.dart';

import 'frame/home.dart';

void main() {
  runApp(InuobusApp());
}

class InuobusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INOBUS application',
      home: HomeFrame(
        title: 'INOBUS',
        backgroundColor: Colors.green,
        pointColor: Colors.white,
      ),
    );
  }
}
