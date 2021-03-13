import 'package:flutter/material.dart';

class Item1 extends StatefulWidget {
  Item1();
  @override
  _Item1 createState() => _Item1();
}

class _Item1 extends State<Item1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item 1'),
      ),
      body: Center(child: Text('Item 1')),
    );
  }
}
