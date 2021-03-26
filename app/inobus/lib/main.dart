import 'package:flutter/material.dart';

import 'frame/home.dart';
import 'frame/introduce.dart';

void main() {
  runApp(InobusApp());
}

class InobusApp extends StatefulWidget {
  @override
  _InobusApp createState() => _InobusApp();
}

class _InobusApp extends State<InobusApp> {
  bool checking = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INOBUS application',
      home: checking
          ? HomeFrame(
              title: 'INOBUS',
              backgroundColor: Colors.orange,
              pointColor: Colors.white,
            )
          : IntroduceFrame(
              onPressButton: () {
                setState(() {
                  checking = true;
                });
              },
            ),
    );
  }
}
