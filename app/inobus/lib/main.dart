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
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  bool checkingIntro = false;
  final Color representativeColor = Color(0xffE8551A);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return MaterialApp(
        title: 'INOBUS application',
        home: checkingIntro
            ? HomeFrame(
                title: 'INOBUS',
                backgroundColor: representativeColor,
                pointColor: Colors.white,
              )
            : IntroduceFrame(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                backgroundColor: representativeColor,
                onPressButton: () {
                  setState(() {
                    checkingIntro = true;
                  });
                },
              ),
        theme: ThemeData(
          // 테마 색상 설정
          accentColor: representativeColor,
        ));
  }
}
