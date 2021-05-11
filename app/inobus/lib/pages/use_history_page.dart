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
  final List<RankText> rankText = [];

  void getOrganizationRank() async {
    var requestOrganizationList = await requestOrganization();
    setState(() {
      orgResult = requestOrganizationList;
    });
  }

  List getRankText(height) {
    setState(() {
      for (var j = 0; j < orgResult.length; j++) {
        rankText.add(
          RankText(
            bottomHeight: height * 0.05,
            rankeText: orgResult[j],
            rank: j + 1,
          ),
        );
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
          child: Expanded(
            child: ListView(
              children: getRankText(screenHeight),
            ),
          ),
        ),
      ),
    );
  }
}

/// 텍스트로 등수 표현
class RankText extends StatelessWidget {
  final int rank;
  final double bottomHeight;
  final Orgainzation rankeText;

  RankText({Key key, this.bottomHeight, this.rankeText, this.rank})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomHeight,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (rank == 1)
            RankRow(
              rank: rank,
              color: Colors.yellow,
            )
          else if (rank == 2)
            RankRow(
              rank: rank,
              color: Colors.grey,
            )
          else if (rank == 3)
            RankRow(
              rank: rank,
              color: Colors.orange,
            )
          else
            RankRow(
              rank: rank,
              color: Colors.white,
            ),
          Text(
            rankeText.name,
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
          Text(
            rankeText.point.toString() + "회",
          ),
        ],
      ),
    );
  }
}

/// 텍스트로 등수 표현의 각 Row에 대한 Container
class RankRow extends StatelessWidget {
  final int rank;
  final Color color;

  RankRow({
    Key key,
    this.rank,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      child: Text(
        rank.toString() + "위",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
