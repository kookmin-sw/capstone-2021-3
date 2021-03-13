import 'package:flutter/material.dart';

class Item2 extends StatefulWidget {
  Item2();
  @override
  _Item2 createState() => _Item2();
}

class _Item2 extends State<Item2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item 2'),
      ),
      body: Center(child: Text('Item 2')),
    );
  }
}
