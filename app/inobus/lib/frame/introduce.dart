import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroduceFrame extends StatefulWidget {
  final VoidCallback onPressButton;

  IntroduceFrame({Key key, this.onPressButton}) : super(key: key);

  @override
  _IntroduceFrame createState() => _IntroduceFrame();
}

class _IntroduceFrame extends State<IntroduceFrame> {
  int selectedIndex;
  PageController pagecontroller;
  List<Image> imgList = [];
  List<Widget> pageList = [];

  void getIntroduceImg() {
    imgList.add(Image.asset('assets/introduce/introduce1.jpg'));
    imgList.add(Image.asset('assets/introduce/introduce2_1.jpg'));
    imgList.add(Image.asset('assets/introduce/introduce2_2.jpg'));
    imgList.add(Image.asset('assets/introduce/introduce2_3.jpg'));
    imgList.add(Image.asset('assets/introduce/introduce2_4.jpg'));
    imgList.add(Image.asset('assets/introduce/introduce2_5.jpg'));
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
    getIntroduceImg();
    super.initState();
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
              child: SmoothPageIndicator(
                  controller: pagecontroller, // PageController
                  count: imgList.length,
                  axisDirection: Axis.vertical,
                  effect: WormEffect(), // your preferred effect
                  onDotClicked: (index) {}))
        ],
      ),
      floatingActionButton:
          TextButton(child: Text("소개 페이지 닫기"), onPressed: widget.onPressButton),
    );
  }
}
