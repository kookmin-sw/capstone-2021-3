import 'package:barcode_widget/barcode_widget.dart';
import 'mainMap.dart';
import 'package:flutter/material.dart';

class MakeBarcodePage extends StatefulWidget {
  MakeBarcodePage({Key key});
  @override
  _MakeBarcodePage createState() => _MakeBarcodePage();
}

class _MakeBarcodePage extends State<MakeBarcodePage> {
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
          Positioned(
            top: screenHeight * 0.4,
            child: BarcodeWidget(
              data: "example",
              barcode: Barcode.code128(),
              width: screenWidth * 0.8,
            ),
          ),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainMapPage()),
                  );
                },
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
