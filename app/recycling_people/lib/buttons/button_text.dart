import 'package:flutter/material.dart';

// 분류 모델 8가지
// 캔류, 종이, 플라스틱, 유리, 페트, 비닐류, 종이팩, 스티로폼

class RecycleTypeButton extends StatefulWidget {
  int typeIndex; //버튼 작동 여부 확인을 위한 임의 값
  RecycleTypeButton(this.typeIndex);

  _RecycleTypeButton createState() => _RecycleTypeButton(this.typeIndex);
}

class _RecycleTypeButton extends State<RecycleTypeButton> {
  String blanck = '          ';

  // type 값을 가져온다.
  _RecycleTypeButton(this.typeIndex);

  // 분리배출표시 도안 종류(8개) + 투명색
  final Map<String, Color> typeColorMap = {
    '캔류': Colors.grey,
    '종이': Colors.black,
    '플라스틱': Colors.blue,
    '유리': Colors.orange,
    '페트': Colors.yellow,
    '비닐류': Colors.purple,
    '종이팩': Colors.green,
    '스티로폼': Colors.pink,
    'None': Colors.transparent
  };

  // 버튼 작동 여부 확인을 위한 임의 변수 및 함수
  int typeIndex = 0;
  final List<String> typeList = [
    '캔류',
    '종이',
    '플라스틱',
    '유리',
    '페트',
    '비닐류',
    '종이팩',
    '스티로폼',
    'None'
  ];

  void _onPressed() {
    setState(() {
      typeIndex++;
      if (typeIndex == 9) {
        typeIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      TextButton(
          onPressed: _onPressed,
          child: Container(
            height: 30,
            width: 150,
            decoration: new BoxDecoration(
              color: typeColorMap[typeList[typeIndex]],
              // 버튼 아웃라인 만들기
              border: new Border.all(
                  color: typeColorMap[typeList[typeIndex]], width: 2.0),
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                      'assets/recyleTypeImage/${typeList[typeIndex]}.jpg'),
                  Text(typeList[typeIndex],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                  Text(this.blanck.substring(
                      0,
                      2 *
                          typeList[typeIndex]
                              .length)) // 보일려는 글자의 2배 크기의 space 만들기
                ]),
          )),
      TextButton(
        // 애니메이션을 보여주는 페이지로 이동을 위한 임의 버튼
        child: Text('Animation'),
      )
    ]);
  }
}
