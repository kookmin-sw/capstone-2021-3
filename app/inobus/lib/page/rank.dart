import 'package:flutter/material.dart';
import '../api/json.dart';

class RankPage extends StatefulWidget {
  RankPage();
  @override
  _RankPage createState() => _RankPage();
}

class _RankPage extends State<RankPage> {
  List<String> rankList;
  final List<RankText> rankText = [];
  final List<RankIcon> rankIcon = [];

  void getOrganizationRank() async {
    var requestOrganizationList = await requestOrganization();
    setState(() {
      rankList = requestOrganizationList;
    });
  }

  List getRank(mediaQuery) {
    setState(() {
      if (rankList.length > 0) {
        rankIcon.add(RankIcon(
            rankColor: Colors.yellow,
            rankSize: mediaQuery.size.width * 0.25,
            rankText: rankList[0]));
      }
      if (rankList.length > 1) {
        rankIcon.add(RankIcon(
            rankColor: Colors.grey,
            rankSize: mediaQuery.size.width * 0.2,
            rankText: rankList[1]));
      }
      if (rankList.length > 2) {
        rankIcon.add(RankIcon(
            rankColor: Colors.brown,
            rankSize: mediaQuery.size.width * 0.15,
            rankText: rankList[2]));

        for (var j = 3; j < rankList.length; j++) {
          rankText.add(
            RankText(
              bottomHeight: mediaQuery.size.height * 0.05,
              rankeText: rankList[j],
              rank: j + 1,
            ),
          );
        }
      }
    });
    return rankText;
  }

  @override
  void initState() {
    super.initState();
    getOrganizationRank();
  }

  @override
  Widget build(BuildContext context) {
    // 반응형으로 만들기 위한 변수
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        body: rankList != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: mediaQuery.size.width * 0.1,
                        bottom: mediaQuery.size.width * 0.1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: rankIcon,
                      ),
                    ),
                    Expanded(
                        //스크롤 가능하게
                        child: ListView(
                      padding: EdgeInsets.only(
                        left: mediaQuery.size.width * 0.1,
                      ),
                      children: getRank(mediaQuery),
                    ))
                  ])
            : Text("Loading"));
  }
}

// 아이콘으로 등수 표현
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
        Text(
          rankText,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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

// 텍스트로 등수 표현
class RankText extends StatelessWidget {
  final int rank;
  final double bottomHeight;
  final String rankeText;

  RankText({Key key, this.bottomHeight, this.rankeText, this.rank})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomHeight),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(rank.toString() + "등 : ",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text(rankeText)
      ]),
    );
  }
}
