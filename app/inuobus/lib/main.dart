import 'package:flutter/material.dart';
import 'package:inuobus/app_frame.dart';
import 'package:inuobus/Page/qr_cod_page.dart';
import 'package:inuobus/Page/map_page.dart';
import 'package:inuobus/Page/rank_page.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  Application();
  @override
  _Application createState() => _Application();
}

class _Application extends State<Application> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    qrCode(),
    GoogleMap(),
    Rank(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INUOBUS application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("test")),
        body: Center(
          child: _children[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_camera_outlined),
              label: 'QR Code',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.military_tech_outlined),
              label: 'Rank',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
