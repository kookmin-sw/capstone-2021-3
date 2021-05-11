import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/widgets/app_scaffold.dart';
import 'package:inobus/app_icons.dart';

class BarcodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    return AppScaffold(
      title: argument.title,
      body: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Positioned(
              child: Text(
                "스캐너는 여기에서 찾을 수 있어요!",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Positioned(
              child: Container(
                child: Image.asset('assets/images/device_image.png'),
                height: screenHeight * 0.2,
              ),
            ),
            Positioned(
              child: Container(
                child: BarcodeWidget(
                  data: "example",
                  barcode: Barcode.code128(),
                ),
                height: screenHeight * 0.15,
                width: screenHeight * 0.4,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Container(
                        height: screenWidth * 0.15,
                        width: screenWidth * 0.15,
                        child: AppIcons.document.icon(),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        primary: Colors.white,
                        onPrimary: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    Center(
                      child: Text("이용내역"),
                    )
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Container(
                        height: screenWidth * 0.15,
                        width: screenWidth * 0.15,
                        child: AppIcons.block.icon(),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        primary: Colors.white,
                        onPrimary: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "바코드 인식이\n안되나요?",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '이용방법을 모를 경우 ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: "이용방법 ",
                      style: TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                    TextSpan(
                      text: "버튼을 눌러주세요.",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
