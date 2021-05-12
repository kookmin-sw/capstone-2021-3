import 'package:flutter/material.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/widgets/app_scaffold.dart';
import 'package:inobus/app_images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// 이용안내
class InformationPage extends StatefulWidget {
  @override
  _InformationPage createState() => _InformationPage();
}

class _InformationPage extends State<InformationPage> {
  int selectedIndex = 0;
  PageController pagecontroller;
  final List<Widget> pageList = [FirstPage(), SecondPage(), ThirdPage()];

  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pagecontroller = PageController(
      initialPage: selectedIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    return AppScaffold(
      title: argument.title,
      body: Expanded(
        child: Stack(
          children: <Widget>[
            PageView(
              controller: pagecontroller,
              scrollDirection: Axis.horizontal,
              children: pageList,
            ),
            Align(
              // 현재 페이지 표시 indexing 이미지
              alignment: Alignment(0.0, 0.9),
              child: Container(
                child: SmoothPageIndicator(
                  controller: pagecontroller,
                  count: pageList.length,
                  axisDirection: Axis.horizontal,
                  effect: WormEffect(
                      dotColor: Colors.grey.withOpacity(.60),
                      activeDotColor: AppColors.primary),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.05,
          left: screenWidth * 0.1,
          child: Container(
            child: AppImages.device.image(),
            height: screenHeight * 0.3,
          ),
        ),
        Positioned(
          top: screenHeight * 0.2,
          left: screenWidth * 0.55,
          child: Container(
            child: AppImages.phone.image(),
            height: screenHeight * 0.3,
          ),
        ),
        Align(
          alignment: Alignment(0.0, 0.7), // (가로, 세로)
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '기기 전면에 바코드를 스캔해요\n',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "앱을 켜고 쓰샘을 찾았다면\n'바코드 열기'버튼을 눌러주세요.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: "\n\n바코드가 나오면 기기에 스탠해주세요.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: "\n.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Stack(
      children: [
        Align(
          alignment: Alignment(0.0, -0.6),
          child: Container(
            child: AppImages.cup.image(),
            height: screenHeight * 0.4,
          ),
        ),
        Align(
          alignment: Alignment(0.0, 0.7), // (가로, 세로)
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '쓰샘으로 제대로 버려요!\n',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "이용하신 일회용 컵을\n쓰샘을 이용해서 버려주세요.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: "\n\n비우기-행구기-분류하기-분리하기\n순으로 완벽하게 처리할 수 있습니다.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Stack(
      children: [
        Align(
          alignment: Alignment(0.0, -0.55),
          child: Container(
            child: AppImages.phone.image(),
            height: screenHeight * 0.4,
          ),
        ),
        Align(
          alignment: Alignment(0.0, 0.7), // (가로, 세로)
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '보상은 바로바로!\n',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "뿌듯한 마음으로 앱을 열고\n",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: "추첨권/포인트 적립 내역을 확인해주세요!",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: "\n\n.\n.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
