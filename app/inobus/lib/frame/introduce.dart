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

  // 쓰샘 사용법 디자인
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
            imgName: "backimg1.png",
            explanation: Stack(children: [
              Explanation(
                  imgName: "img1.png",
                  text: " 컵 뚜껑, 홀더, 빨대를 \n 분리수거 합니다.",
                  number: 1,
                  baseColor: widget.backgroundColor),
              Explanation(
                  imgName: "img2.png",
                  text: " 남은 음료를 버려줍니다.",
                  number: 2,
                  baseColor: widget.backgroundColor)
            ]))));
    imgList.add(Container(
        child: IntroducePage(
            imgName: "backimg2.png",
            explanation: Stack(
              children: [
                Explanation(
                    imgName: "img3.png",
                    text: " 컵을 거꾸로 놓고 눌러 \n 세척합니다.",
                    number: 3,
                    baseColor: widget.backgroundColor),
                Explanation(
                    imgName: "img4.png",
                    text: " 세척된 플라스틱 컵을 \n '쓰샘'에 넣어줍니다.",
                    number: 4,
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
              top: widget.screenHeight * 0.5,
              left: widget.screenWidth * 0.02,
              child: Container(
                child: SmoothPageIndicator(
                    controller: pagecontroller,
                    count: imgList.length,
                    axisDirection: Axis.vertical,
                    effect: WormEffect(
                        dotColor: Colors.grey.withOpacity(.60),
                        activeDotColor: Colors.blue),
                    onDotClicked: (index) {}),
              ))
        ],
      ),
      floatingActionButton:
          TextButton(child: Text("소개 페이지 닫기"), onPressed: widget.onPressButton),
    );
  }
}

/// 소개 페이지 중 기기 사용법 설명 배경 설정 widget
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
            fit: BoxFit.fitWidth, //가로를 기준으로 맞추기
          ),
        ),
        child: explanation);
  }
}

/// 쓰샘 기기 사용법 설명 widget
class Explanation extends StatelessWidget {
  final Color baseColor;
  final String imgName;
  final String text;
  final int number;

  Explanation({
    Key key,
    this.imgName,
    this.text,
    this.number,
    this.baseColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    final double radius = screenWidth * 0.08; // 반지름
    final double bottomMargin = screenHeight * 0.5 * (number % 2 == 1 ? 1 : 0);
    final double leftMargin = screenWidth * 0.3;

    return Stack(children: <Widget>[
      // 설명 이미지
      Positioned(
          bottom: bottomMargin + radius * 4,
          left: leftMargin + radius,
          child: Container(
              width: screenWidth * 0.5,
              height: screenWidth * 0.5,
              child: Image.asset("assets/introduce/${this.imgName}"))),
      // 동그라미
      Positioned(
          bottom: bottomMargin + radius * 2,
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
        bottom: bottomMargin + radius * 2,
        left: leftMargin + radius * 2,
        child: Container(
          height: radius * 2,
          width: screenWidth * 0.5,
          child: Center(
              child: Text(
            this.text,
            style: TextStyle(fontSize: radius * 0.6),
          )),
        ),
      )
    ]);
  }
}
