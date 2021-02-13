import 'package:flutter/material.dart';

// 분류 모델 8가지
// 캔류, 종이, 플라스틱, 유리, 페트, 비닐류, 종이팩, 스티로폼

// StatefulWidget
// StatelessWidget
class ButtonText extends StatefulWidget {
  int type_index; //버튼 작동 여부 확인을 위한 임의 값
  String type;
  ButtonText(this.type_index);

  _ButtonText createState() => _ButtonText(this.type_index);
}

class _ButtonText extends State<ButtonText> {
  String type; //원하는 분리배출표시
  String blanck = '          ';

  // 분리배출표시 도안 종류(8개) + 투명색
  final Map<String, Color> type_map = {
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

  // 버튼 작동 여부 확인을 위한 임의 변수
  int type_index = 0;
  final List<String> type_list = [
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

  // type 값을 가져온다.
  _ButtonText(this.type_index);

  void _onPressed() {
    setState(() {
      type_index++;
      if (type_index == 9) {
        type_index = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: _onPressed,
        child: Container(
            height: 30,
            width: 150,
            decoration: new BoxDecoration(
              color: type_map[type_list[type_index]],
              // 버튼 아웃라인 만들기
              border: new Border.all(
                  color: type_map[type_list[type_index]], width: 2.0),
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                      'assets/recyleTypeImage/${type_list[type_index]}.jpg'),
                  Text(type_list[type_index],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                  Text(this.blanck.substring(
                      0,
                      2 *
                          type_list[type_index]
                              .length)) // 보일려는 글자의 2배 크기의 space 만들기
                ])));
  }
}
