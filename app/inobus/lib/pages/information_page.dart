import 'package:flutter/material.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/app_images.dart';
import 'package:inobus/routes.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/widgets/app_scaffold.dart';
import 'package:inobus/widgets/circle_button.dart';

/// 이용안내
class InformationPage extends StatefulWidget {
  @override
  _InformationPage createState() => _InformationPage();
}

class _InformationPage extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return AppScaffold(
      title: argument.title,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            //이용방법
            Text(
              "이용방법",
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey,
              ),
            ),
            OutlineCircleButton(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: AppImages.device.image(),
                    width: 100,
                  ),
                ],
              ),
              radius: 180.0,
              borderSize: 1.0,
              borderColor: Colors.grey,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.infoExplan,
                  arguments: RouteArgument(
                    title: "이용안내",
                    selectList: 0, // 0:이용방법, 1:서비스 안내
                  ),
                );
              },
            ),
            RoundedRectangleBorderButton(
              child: Text("    보러가기     >"),
              backgroudColor: AppColors.primary,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.infoExplan,
                  arguments: RouteArgument(
                    title: "이용안내",
                    selectList: 0, // 0:이용방법, 1:서비스 안내
                  ),
                );
              },
            ),
            Divider(color: Colors.grey),
            //이용방법
            Text(
              "추첨권/포인트 서비스 안내",
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey,
              ),
            ),
            OutlineCircleButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: screenWidth * 0.2,
                    child: AppImages.smilePurple.image(),
                  ),
                  Container(
                    height: screenWidth * 0.2,
                    child: AppImages.point.image(),
                  )
                ],
              ),
              radius: 180.0,
              borderSize: 1.0,
              borderColor: Colors.grey,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.infoExplan,
                  arguments: RouteArgument(
                    title: "이용안내",
                    selectList: 1, // 0:이용방법, 1:서비스 안내
                  ),
                );
              },
            ),
            RoundedRectangleBorderButton(
              child: Text("    보러가기     >"),
              backgroudColor: AppColors.primary,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.infoExplan,
                  arguments: RouteArgument(
                    title: "이용안내",
                    selectList: 1, // 0: 기기 사용법, 1: 추첨권 사용법 설명
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
