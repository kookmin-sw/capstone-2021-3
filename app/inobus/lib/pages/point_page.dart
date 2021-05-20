import 'package:flutter/material.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/app_icons.dart';
import 'package:inobus/app_images.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/widgets/app_scaffold.dart';

/// 추첨권-포인트
class PointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final pointSize = screenWidth * 0.07;
    final marginRight = 30.0;
    return AppScaffold(
      title: argument.title,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // 추첨권 텍스트
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '매월 1일\n',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: pointSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "행운의 주인공",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: pointSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "이 되어보세요!",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: pointSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // 이번달 추첨권 개수 알려주기
          Text(
            "****월 **일 추첨권",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          // 티켓 박스
          Container(
            height: screenHeight * 0.2,
            margin: EdgeInsets.only(
              left: marginRight * 0.8,
              right: marginRight * 0.8,
            ),
            padding: EdgeInsets.only(
              top: marginRight * 0.8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
                width: 3,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: screenWidth * 0.2,
                      child: AppImages.appleLogo.image(),
                    ),
                    Container(
                      width: screenWidth * 0.2,
                      child: AppImages.googleLogo.image(),
                    ),
                    Container(
                      width: screenWidth * 0.2,
                      child: AppImages.googleLogo.image(),
                    )
                  ],
                ),
                Text(
                  "*개의 추첨권이 남았어요!",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: marginRight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "이달의 추첨상품 알아보기 >  ",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          // 적립된 포인트 알려주기
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '지금까지 모은 ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: pointSize * 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "포인트",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: pointSize * 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "는?",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: pointSize * 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // 이미지 말고 동그라미로 변경
          Container(
            child: AppImages.appleLogo.image(),
            width: screenWidth * 0.3,
          ),
          // 마켓 가기 박스
          Container(
            margin: EdgeInsets.only(right: marginRight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "적립내역 >  ",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: marginRight, right: marginRight),
            padding: EdgeInsets.only(
                left: marginRight * 0.5, right: marginRight * 0.5),
            decoration: BoxDecoration(
              color: Colors.black87,
              border: Border.all(
                color: Colors.yellow,
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Image.asset(
                    AppIcons.cart.path,
                    color: Colors.yellow,
                  ),
                  height: screenWidth * 0.2,
                ),
                Text(
                  "포인트로 에코 마켓을\n이용해보세요!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "마켓\n보기",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.all(5),
                      primary: Colors.yellow,
                      onPrimary: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
