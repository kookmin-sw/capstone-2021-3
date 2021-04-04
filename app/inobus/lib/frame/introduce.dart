import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroduceFrame extends StatefulWidget {
  final VoidCallback onPressButton;
  final Color backgroundColor;
  final double screenHeight;
  final double screenWidth;

  IntroduceFrame(
      {Key key,
      this.onPressButton,
      this.backgroundColor,
      this.screenHeight,
      this.screenWidth})
      : super(key: key);

  @override
  _IntroduceFrame createState() => _IntroduceFrame();
}

class _IntroduceFrame extends State<IntroduceFrame> {
  int selectedIndex = 0;
  PageController pagecontroller;
  final List<Container> imgList = [];

  void getIntroduceImg() {
    imgList.add(Container(
        child: Image.asset(
      'assets/introduce/introduce1.jpg',
      fit: BoxFit.fitWidth,
    )));
    imgList.add(Container(
        child: Image.asset('assets/introduce/introduce2.jpg',
            fit: BoxFit.fitWidth)));
    imgList.add(Container(
        child: IntroducePage(
            imgName: "introduce_backimg1.PNG",
            explanation: Stack(children: [
              Explanation(
                  imgName: "img1.jpg",
                  text: " 컵 뚜껑, 홀더, 빨대를 \n 분리수거 합니다.",
                  number: 1,
                  screenHeight: widget.screenHeight,
                  screenWidth: widget.screenWidth,
                  baseColor: widget.backgroundColor),
              Explanation(
                  imgName: "img2.jpg",
                  text: " 남은 음료를 버려줍니다",
                  number: 2,
                  screenHeight: widget.screenHeight,
                  screenWidth: widget.screenWidth,
                  baseColor: widget.backgroundColor)
            ]))));
    imgList.add(Container(
        child: IntroducePage(
            imgName: "introduce_backimg2.PNG",
            explanation: Stack(
              children: [
                Explanation(
                    imgName: "img3.jpg",
                    text: " 컵을 거꾸로 놓고 눌러 \n 세척합니다.",
                    number: 3,
                    screenHeight: widget.screenHeight,
                    screenWidth: widget.screenWidth,
                    baseColor: widget.backgroundColor),
                Explanation(
                    imgName: "img4.jpg",
                    text: " 세척된 플라스틱 컵을 \n '쓰샘'에 넣어줍니다.'",
                    number: 4,
                    screenHeight: widget.screenHeight,
                    screenWidth: widget.screenWidth,
                    baseColor: widget.backgroundColor)
              ],
            ))));
  }

  // 손으로 페이지를 넘겼을 때
  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getIntroduceImg();
    // this.selectedIndex = 0;
    this.pagecontroller = PageController(
      initialPage: this.selectedIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: pagecontroller,
            scrollDirection: Axis.vertical,
            children: imgList,
            onPageChanged: (index) {
              pageChanged(index);
            },
          ),
          // 현재 페이지 표시 indexing 이미지
          Positioned(
              top: widget.screenHeight * 0.3,
              left: widget.screenWidth * 0.02,
              child: SmoothPageIndicator(
                  controller: pagecontroller,
                  count: imgList.length,
                  axisDirection: Axis.vertical,
                  effect: WormEffect(
                      dotColor: Colors.grey.withOpacity(.60),
                      activeDotColor: Colors.blue),
                  onDotClicked: (index) {}))
        ],
      ),
      floatingActionButton:
          TextButton(child: Text("소개 페이지 닫기"), onPressed: widget.onPressButton),
    );
  }
}

// 소개 페이지 중 기기 사용법 설명 배경 설정 widget
class IntroducePage extends StatelessWidget {
  final String imgName;
  final explanation;

  IntroducePage({Key key, this.imgName, this.explanation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // 배경 이미지 결정
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/introduce/${this.imgName}"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: explanation);
  }
}

// 쓰샘 기기 사용법 설명 widget
class Explanation extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final String imgName;
  final String text;
  final int number;
  final Color baseColor;

  Explanation(
      {Key key,
      this.imgName,
      this.text,
      this.number,
      this.baseColor,
      this.screenHeight,
      this.screenWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius = screenWidth * (1 / 3) - screenWidth * (1 / 4);
    final double topMargin =
        (number % 2 == 1 ? 1 : 2) * screenHeight * (4 / 10);
    final double leftMargin = screenWidth * (1 / 4);

    return Stack(children: <Widget>[
      // 설명 이미지
      Positioned(
          top: number % 2 == 1
              ? screenHeight * (1 / 20)
              : screenHeight * (11 / 20),
          left: leftMargin + radius,
          child: Container(
              width: screenWidth * (1 / 2),
              height: screenWidth * (1 / 2),
              child: Image.asset("assets/introduce/${this.imgName}"))),
      // 동그라미
      Positioned(
          top: number % 2 == 1 ? topMargin - radius : topMargin + radius,
          left: leftMargin,
          child: Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                width: 5,
                color: this.baseColor,
                style: BorderStyle.solid,
              ),
            ),
            child: Center(
                child: Text(this.number.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: this.baseColor,
                        fontSize: radius))),
          )),
      // 설명 텍스트
      Positioned(
          top: number % 2 == 1 ? topMargin - radius : topMargin + radius,
          left: leftMargin + radius * 2,
          child: Text(
            this.text,
            style: TextStyle(fontSize: radius * (2 / 3)),
          ))
    ]);
  }
}
