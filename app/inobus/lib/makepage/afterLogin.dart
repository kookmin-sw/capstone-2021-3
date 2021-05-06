import 'package:flutter/material.dart';
import 'makebarcode.dart';

class AfterLoginPage extends StatefulWidget {
  AfterLoginPage({Key key});
  @override
  _AfterLoginPage createState() => _AfterLoginPage();
}

class _AfterLoginPage extends State<AfterLoginPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: screenHeight * 0.15,
            child: Text(
              "회원가입을 축하합니다!",
              style: TextStyle(
                color: Color(0xff6e6e6e),
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.23,
            child: Text(
              "쓰샘을 통해 지구의\n영웅이 되어주세요!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.35,
            child: Image.asset(
              "assets/image/hero_img.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: screenHeight * 0.8,
            child: Container(
              width: screenWidth * 0.7,
              height: screenHeight * 0.1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MakeBarcodePage()),
                  );
                },
                child: Text(
                  "바코드 만들로 가기",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff5234eb),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
