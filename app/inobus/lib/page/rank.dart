import 'package:flutter/material.dart';

class RankPage extends StatefulWidget {
  RankPage();
  @override
  _RankPage createState() => _RankPage();
}

class _RankPage extends State<RankPage> {
  @override
  Widget build(BuildContext context) {
    // 반응형으로 만들기 위한 변수
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RankIcon(
                  rankColor: Colors.grey,
                  rankSize: mediaQuery.size.width * 0.2,
                  rankText: "222222222222"),
              RankIcon(
                  rankColor: Colors.yellow,
                  rankSize: mediaQuery.size.width * 0.25,
                  rankText: "11111111111"),
              RankIcon(
                  rankColor: Colors.brown,
                  rankSize: mediaQuery.size.width * 0.15,
                  rankText: "33333333333"),
            ]),
        Padding(
          padding: EdgeInsets.only(
            left: mediaQuery.size.width * 0.1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RankText(
                  bottomHeight: mediaQuery.size.height * 0.05,
                  rankeText: "4등 : 444444444444"),
              RankText(
                  bottomHeight: mediaQuery.size.height * 0.05,
                  rankeText: "5등 : 5555555555555"),
              RankText(
                  bottomHeight: mediaQuery.size.height * 0.05,
                  rankeText: "6등 : 6666666666666")
            ],
          ),
        )
      ],
    ));
  }
}

class RankIcon extends StatelessWidget {
  final double rankSize;
  final String rankText;
  final Color rankColor;

  RankIcon({Key key, this.rankSize, this.rankText, this.rankColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(rankText),
        Icon(
          Icons.emoji_events,
          color: rankColor,
          size: rankSize,
        ),
        if (rankColor == Colors.yellow)
          Text("1등")
        else if (rankColor == Colors.grey)
          Text("2등")
        else if (rankColor == Colors.brown)
          Text("3등")
      ],
    );
  }
}

class RankText extends StatelessWidget {
  final double bottomHeight;
  final String rankeText;

  RankText({Key key, this.bottomHeight, this.rankeText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomHeight),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text(rankeText)]),
    );
  }
}
