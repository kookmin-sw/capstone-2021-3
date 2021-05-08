import 'package:flutter/material.dart';
import 'package:inobus/login/google_login.dart';

class MakeBarcodePage extends StatelessWidget {
  final VoidCallback onNextPage;

  MakeBarcodePage({Key key, this.onNextPage});

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
              "나만의 바코드\n이름을 지어주세요!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff6e6e6e),
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.3,
            child: Text(
              "바코드는 쓰샘 이용시 필요합니다.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          Positioned(top: screenHeight * 0.4, child: GoogleUser.barcod),
          Positioned(
            bottom: screenHeight * 0.25,
            child: SizedBox(
              width: screenWidth * 0.8,
              child: TextField(
                cursorColor: Color(0xff5234eb),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '이름을 입력해 주세요',
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.15,
            child: Container(
              width: screenWidth * 0.23,
              height: screenHeight * 0.07,
              child: ElevatedButton(
                onPressed: onNextPage,
                child: Text(
                  "완료",
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
