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
  bool checking = false;
  final Color representativeColor = Color(0xffF04C18);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return MaterialApp(
        title: 'INOBUS application',
        home: checking
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
                    checking = true;
                  });
                },
              ),
        theme: ThemeData(
          // 테마 색상 설정
          accentColor: representativeColor,
        ));
  }
}


// class _InobusApp extends State<InobusApp> {
//   bool checking = false;
//   final Color representativeColor = Color(0xffF04C18);

//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     var width = screenSize.width;
//     var height = screenSize.height;
//     print("높이 : " + width.toString());
//     print("넓이 : " + height.toString());
//     print("프린트문 확인");
//     return MaterialApp(
//         title: 'INOBUS application',
//         home: checking
//             ? HomeFrame(
//                 title: 'INOBUS',
//                 backgroundColor: representativeColor,
//                 pointColor: Colors.white,
//               )
//             : IntroduceFrame(
//                 // screenHeight: ,
//                 // screenWidth: ,
//                 backgroundColor: representativeColor,
//                 onPressButton: () {
//                   setState(() {
//                     checking = true;
//                   });
//                 },
//               ),
//         theme: ThemeData(
//           // 테마 색상 설정
//           accentColor: representativeColor,
//         ));
//   }
// }
