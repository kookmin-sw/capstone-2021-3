import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:flutter/cupertino.dart';

class AnimationRecyle extends StatefulWidget {
  final String typeNameK;
  AnimationRecyle(this.typeNameK);

  @override
  _AnimationRecyleState createState() => _AnimationRecyleState(this.typeNameK);
}

class _AnimationRecyleState extends State<AnimationRecyle> {
  String _riveFileName;
  String _typeNameK; // 한국어로된 소재 명칭
  String _typeNameE; // 영어로된 소재 명칭
  int _animationNum = 1;

  List _animationTextList = [];
  List<Widget> _textButtonList = [];

  RiveAnimationController _controller;
  Artboard _riveArtboard;

  _AnimationRecyleState(this._typeNameK);

  // 각 소재에 매칭 되는 riv 애니메이션 명칭
  final Map<String, String> typeNameMap = {
    '캔류': 'can',
    '종이': 'paper',
    '플라스틱': 'plastic',
    '유리': 'glass',
    '페트': 'patebottle',
    '비닐류': 'vinyl',
    '종이팩': 'paperpack',
    '스티로폼': 'styrofoam',
    'None': ''
  };

  @override
  void initState() {
    super.initState();
    _typeNameE = typeNameMap[_typeNameK];
    _riveFileName = 'assets/animation/${this._typeNameE}.riv';
    loadRiveFile(this._animationNum);
  }

  void onPress(int num) {
    setState(() {
      if (num == _animationNum) {
        _controller.isActive = !_controller.isActive;
      } else {
        loadRiveFile(num);
        _animationNum = num;
      }
    });
  }

  void loadRiveFile(int num) async {
    final data = await rootBundle.load(_riveFileName);
    final file = RiveFile();

    if (file.import(data)) {
      setState(() {
        _riveArtboard = file.mainArtboard;
        _controller = SimpleAnimation('anim${num.toString()}');
        _riveArtboard.addController(_controller);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this._typeNameK} 분리배출 방법'),
      ),
      body: Column(
        children: [
          Positioned(
              left: 0,
              child: TextButton(
                  onPressed: () {
                    onPress(1);
                  },
                  child: Text('Play1'))),
          Positioned(
              left: 50,
              child: TextButton(
                  onPressed: () {
                    onPress(2);
                  },
                  child: Text('Play2'))),
          Positioned(
              left: 100,
              child: TextButton(
                  onPressed: () {
                    onPress(3);
                  },
                  child: Text('Play3'))),
          Positioned(
              left: 150,
              child: TextButton(
                  onPressed: () {
                    onPress(4);
                  },
                  child: Text('Play4'))),
          Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: _riveArtboard == null
                  ? Text(_typeNameE)
                  : Rive(artboard: _riveArtboard))
        ],
      ),
    );
  }
}
