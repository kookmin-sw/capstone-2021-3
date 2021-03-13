import 'package:flutter/material.dart';

import 'page/google_map_page.dart';
import 'page/qr_scan_page.dart';
import 'page/rank_page.dart';

import 'page/item1.dart';
import 'page/item2.dart';

void main() {
  runApp(InuobusApp());
}

class InuobusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Frame(title: 'INUOBUS'),
    );
  }
}

class Frame extends StatefulWidget {
  Frame({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Frame createState() => _Frame();
}

class _Frame extends State<Frame> {
  int selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> bodyCenter = [
    QRScan(),
    GoogleMap(),
    Rank(),
    Item1(),
    Item2()
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        // 앱바
        appBar: AppBar(
          title: Text(widget.title),
        ),
        // 내용
        body: Center(
          child: bodyCenter[selectedIndex],
        ),
        // 네비게이션 바
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          selectedFontSize: mediaQuery.size.width * 0.05,
          unselectedFontSize: mediaQuery.size.width * 0.03,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: 'QR Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events),
              label: 'Rank',
            ),
          ],
        ),
        // 메뉴
        endDrawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          SizedBox(
            height: mediaQuery.size.height * 0.2,
            child: DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text("Somthing data want")],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(mediaQuery.size.width * 0.035)),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => bodyCenter[3]));
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => bodyCenter[4]));
            },
          ),
        ])));
  }
}
