import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/routes.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/widgets/app_scaffold.dart';
import 'package:inobus/app_icons.dart';
import 'package:inobus/app_images.dart';

/// 바코드
class BarcodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
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
                child: AppImages.device.image(),
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
            // 아래 동그란 버튼 2개
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleImageButton(
                  bottomText: "이용방법",
                  image: AppIcons.document.icon(),
                  routPage: Routes.information,
                  routTitle: "이용안내",
                ),
                CircleImageButton(
                  bottomText: "바코드 인식이\n안되나요?",
                  image: AppIcons.block.icon(),
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

/// 동그란 버튼 with icon(Image)
class CircleImageButton extends StatelessWidget {
  final String bottomText;
  final Image image;
  final routPage;
  final routTitle;
  CircleImageButton(
      {Key key, this.bottomText, this.image, this.routPage, this.routTitle});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            if (routPage != null) {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                routPage,
                arguments: RouteArgument(title: routTitle),
              );
            }
          },
          child: Container(
            height: screenWidth * 0.15,
            width: screenWidth * 0.15,
            child: this.image,
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
            this.bottomText,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
