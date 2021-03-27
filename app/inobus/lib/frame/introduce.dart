import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroduceFrame extends StatefulWidget {
  final VoidCallback onPressButton;
  final Color backgroundColor;

  IntroduceFrame({Key key, this.onPressButton, this.backgroundColor})
      : super(key: key);

  @override
  _IntroduceFrame createState() => _IntroduceFrame();
}

class _IntroduceFrame extends State<IntroduceFrame> {
  int selectedIndex;
  PageController pagecontroller;
  List<Container> imgList = [];
  List<Widget> pageList = [];

  void getIntroduceImg() {
    imgList.add(Container(
        child: Image.asset(
      'assets/introduce/introduce1.jpg',
      fit: BoxFit.fitWidth,
    )));
    imgList.add(Container(
        child: Image.asset('assets/introduce/introduce.PNG',
            fit: BoxFit.fitWidth)));
    imgList.add(Container(
        child: IntroducePage(
            namePNG: "introduce1",
            text: "TEST1",
            number: 1,
            baseColor: widget.backgroundColor)));
    imgList.add(Container(
        child: IntroducePage(
            namePNG: "introduce2",
            text: "TEST2",
            number: 2,
            baseColor: widget.backgroundColor)));
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
    this.selectedIndex = 0;
    this.pagecontroller = PageController(
      initialPage: this.selectedIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
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
          Positioned(
              top: mediaQuery.size.height * 0.3,
              left: mediaQuery.size.width * 0.02,
              child: SmoothPageIndicator(
                  controller: pagecontroller, // PageController
                  count: imgList.length,
                  axisDirection: Axis.vertical,
                  effect: WormEffect(
                      // paintStyle: PaintingStyle.stroke,
                      dotColor: Colors.grey.withOpacity(.60),
                      activeDotColor: Colors.blue), // your preferred effect
                  onDotClicked: (index) {}))
        ],
      ),
      floatingActionButton:
          TextButton(child: Text("소개 페이지 닫기"), onPressed: widget.onPressButton),
    );
  }
}

// IntroducePage(
//   namePNG: "introduce1",
//   text: "test1",
//   number: 1,
//   baseColor: widget.backgroundColor));
class IntroducePage extends StatelessWidget {
  final String namePNG;
  final String text;
  final int number;
  final Color baseColor;

  IntroducePage({Key key, this.namePNG, this.text, this.number, this.baseColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/introduce/${this.namePNG}.PNG"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Stack(children: [
          Positioned(top: 400, left: 200, child: Text(this.text)),
          Positioned(
              top: 400,
              left: 100,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    width: 8,
                    color: this.baseColor,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                    child: Text(this.number.toString(),
                        style:
                            TextStyle(color: this.baseColor, fontSize: 50.0))),
              )),
        ]));
  }
}
