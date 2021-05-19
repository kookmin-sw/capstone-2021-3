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
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0.0, -0.9),
              child: Text(
                "스캐너는 여기에서 찾을 수 있어요!",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.7),
              child: Container(
                child: AppImages.device.image(),
                height: screenHeight * 0.2,
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.05),
              child: Container(
                child: BarcodeWidget(
                  data: "example",
                  barcode: Barcode.code128(),
                ),
                height: screenHeight * 0.2,
                width: screenHeight * 0.4,
              ),
            ),
            // 아래 동그란 버튼 2개
            Align(
              alignment: Alignment(-0.4, 0.45),
              child: CircleImageButton(
                bottomText: "이용방법",
                image: AppIcons.document.icon(),
                routPage: Routes.infoExplan,
                routTitle: "이용안내",
              ),
            ),
            Align(
              alignment: Alignment(0.4, 0.45),
              child: CircleImageButton(
                bottomText: "인식불가",
                image: AppIcons.block.icon(),
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.8),
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
    return Container(
      width: 80,
      height: 80,
      child: MaterialButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            this.image,
            Text(
              this.bottomText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: BorderSide(color: Colors.grey),
        ),
        color: Colors.white,
        textColor: AppColors.primary,
        onPressed: () {
          if (routPage != null) {
            Navigator.pushNamed(
              context,
              routPage,
              arguments: RouteArgument(
                title: routTitle,
                selectList: 0, // 0: 기기 사용법, 1: 추첨권 사용법 설명
              ),
            );
          }
        },
      ),
    );
  }
}
