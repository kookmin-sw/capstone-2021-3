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
  int selectedIndex = 0;

  void _onItemTapped(int index) {
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
      body: Center(
        child: bodyCenter[selectedIndex],
      ),
      // 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: widget.backgroundColor,
        selectedItemColor: widget.pointColor,
        unselectedItemColor: widget.pointColor.withOpacity(.60),
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
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
