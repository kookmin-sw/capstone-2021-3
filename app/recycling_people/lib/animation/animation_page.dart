import 'package:flutter/material.dart';

class AnimationRecyle extends StatefulWidget {
  final String typeNameK;
  AnimationRecyle(this.typeNameK);

  @override
  _AnimationRecyleState createState() => _AnimationRecyleState(this.typeNameK);
}

class _AnimationRecyleState extends State<AnimationRecyle> {
  String _typeNameK; // 한국어로된 소재 명칭
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this._typeNameK} 분리배출 방법'),
      ),
    );
  }
}
