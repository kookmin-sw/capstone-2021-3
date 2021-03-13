import 'package:flutter/material.dart';

import 'page/google_map_page.dart';
import 'page/qr_scan_page.dart';
import 'page/rank_page.dart';

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
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [QRScan(), GoogleMap(), Rank()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: _children[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
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
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,
        ));
  }
}
