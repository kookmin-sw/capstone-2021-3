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

  void initState() {
    super.initState();
    this.selectedIndex = 0;
    this.pagecontroller = PageController(
      initialPage: this.selectedIndex,
    );
  }

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
    return Scaffold(
      // 앱바
      appBar: AppBar(
        backgroundColor: widget.backgroundColor,
        title: Text(widget.title),
      ),
      // 내용
      body: PageView(
        controller: pagecontroller,
        children: bodyCenter,
        onPageChanged: (index) {
          pageChanged(index);
        },
      ),
      // 네비게이션 바
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
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'QR Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Rank',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
