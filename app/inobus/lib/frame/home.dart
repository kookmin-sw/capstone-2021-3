import 'package:flutter/material.dart';

import '../page/map.dart';
import '../page/qr.dart';
import '../page/rank.dart';
import '../page/menu.dart';

class HomeFrame extends StatefulWidget {
  HomeFrame({Key key, this.title, this.backgroundColor, this.pointColor})
      : super(key: key);
  final String title;
  final Color backgroundColor;
  final Color pointColor;

  @override
  _HomeFrame createState() => _HomeFrame();
}

class _HomeFrame extends State<HomeFrame> {
  int selectedIndex;
  PageController pagecontroller;

  @override
  void initState() {
    super.initState();
    this.selectedIndex = 2;
    this.pagecontroller = PageController(
      initialPage: this.selectedIndex,
    );
  }

  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  // 네비게이션 버튼을 눌렀을 때
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      pagecontroller.animateToPage(selectedIndex,
          duration: Duration(milliseconds: 100), curve: Curves.linear);
    });
  }

  // 손으로 페이지를 넘겼을 때
  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> bodyCenter = [MapPage(), QRPage(), RankPage(), MenuPage()];

  @override
  Widget build(BuildContext context) {
    // 상단 앱바 높이, 길이
    var appBarHeight = AppBar().preferredSize.height;
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      // 상단 앱바 구성
      appBar: AppBar(
        backgroundColor: widget.backgroundColor,
        title: Row(children: [
          Container(
            height: appBarHeight * 0.9,
            child: Image.asset('assets/image/logo_just_image.png'),
          ),
          Padding(
            padding: EdgeInsets.only(left: mediaQuery.size.width * 0.05),
            child: Text(widget.title,
                style: TextStyle(fontSize: appBarHeight * 0.6)),
          )
        ]),
      ),

      // 페이지 구성
      body: PageView(
        controller: pagecontroller,
        children: bodyCenter,
        onPageChanged: (index) {
          pageChanged(index);
        },
      ),

      // 하단 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: widget.backgroundColor,
        selectedItemColor: widget.pointColor,
        unselectedItemColor: widget.pointColor.withOpacity(.60),
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '지도',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR 코드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: '순위',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '메뉴',
          ),
        ],
      ),
    );
  }
}
