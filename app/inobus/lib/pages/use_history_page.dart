import 'package:flutter/material.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/widgets/app_scaffold.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/app_size.dart';
import 'package:inobus/api/orgainzation.dart';

class UseHistoryPage extends StatefulWidget {
  UseHistoryPage({Key key});
  @override
  _UseHistoryPage createState() => _UseHistoryPage();
}

class _UseHistoryPage extends State<UseHistoryPage> {
  List<Orgainzation> orgResult = [];
  final List<RankRow> rankText = [];

  void getOrganizationRank() async {
    var requestOrganizationList = await requestOrganization();
    setState(() {
      orgResult = requestOrganizationList;
    });
    getRankText();
  }

  void getRankText() {
    setState(() {
      for (var j = 0; j < orgResult.length; j++) {
        rankText.add(
          RankRow(
            rankeText: orgResult[j],
            rank: j + 1,
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getOrganizationRank();
  }

  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    var screenHeight = ScreenSize(context).height;
    return AppScaffold(
      title: argument.title,
      body: Center(
        child: Container(
          height: screenHeight * 0.5,
          margin: const EdgeInsets.all(30.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            border: Border.all(
              width: 2,
              color: AppColors.primary,
            ),
          ),
          child: ListView(
            children: rankText,
          ),
        ),
      ),
    );
  }
}

/// 텍스트로 등수 표현
class RankRow extends StatelessWidget {
  final int rank;
  final Orgainzation rankeText;

  RankRow({Key key, this.rankeText, this.rank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: RankCircle(
        rank: this.rank,
        color: this.rank == 1
            ? Colors.yellow
            : this.rank == 2
                ? Colors.grey
                : this.rank == 3
                    ? Color(0xFFb86c39)
                    : Colors.purple[50],
      ),
      title: Text(
        rankeText.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        rankeText.point.toString() + "회",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      // onTap: () => {},
      // enabled: false,
    );
  }
}

/// 제일 앞의 등수 숫자로 표현
class RankCircle extends StatelessWidget {
  final int rank;
  final Color color;

  RankCircle({
    Key key,
    this.rank,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(5.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: rank < 10
          ? Text(
              rank.toString() + "위",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          : Text(
              rank.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
