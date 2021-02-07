import 'package:flutter/material.dart';

// 분류 모델 11가지
// 종이류, 금속캔, 고철류, 유리병류, 플라스틱류, 비닐류, 스티로폼, 음식물, 재사용, 종이팩, 투명패트

//StatefulWidget
class ButtonText extends StatelessWidget {
  int type_index;    //원하는 분리배출표시 리스트의 순서
  String blanck = '          ';

  // 분리배출표시 도안 종류 (7개)
  final List<String> _type = [
    '페트',
    '플라스틱', 
    '비닐류',
    '캔류',
    '종이팩',
    '종이',
    '유리'
  ];

  // 각 분리배출표시 도안의 색상
  final List<Color> _color = [
    Colors.yellow,
    Colors.blue,
    Colors.purple,
    Colors.grey,
    Colors.green,
    Colors.black,
    Colors.orange
  ];

  void _onPressed(){
    type_index ++;
    if(type_index == 7) {type_index = 0;}
  }

  // 처음에 index를 받아와야 한다
  ButtonText(this.type_index);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _onPressed, 
      child: Container(
        // margin: EdgeInsets.all(10),
        color: _color[type_index],
        height: 30,
        width: 150,
        child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.play_arrow),
                Text(
                  _type[type_index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white
                  )
                ),
                Text(this.blanck.substring(0, 2*_type[type_index].length)) // 보일려는 글자의 2배 크기의 space 만들기
              ]
            )
      )
    );
  }
}