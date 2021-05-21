import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:inobus/api/user.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/models/auth_service.dart';
import 'package:inobus/widgets/app_scaffold.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/app_size.dart';
import 'package:inobus/api/orgainzation.dart';
import 'package:inobus/widgets/circle_button.dart';

double minFointSize = 12;
double maxFointSize = 20;

/// 이용내역
class UserHistoryPage extends StatefulWidget {
  UserHistoryPage({Key key});
  @override
  _UserHistoryPage createState() => _UserHistoryPage();
}

class _UserHistoryPage extends State<UserHistoryPage> {
  bool loading = false;
  List<Orgainzation> orgResult = [];
  List<RankRow> rankText = [];
  List<User> userHistoryList = [];

  // 사용자 월별 포인트 값 가져오기
  void getUserPointHistory() async {
    final requesttUserPointHistoryList = await requesttUserPointHistory();
    setState(() {
      userHistoryList = requesttUserPointHistoryList;
    });
  }

  // 전체 기관별 순위 가져오기
  void getOrganizationRank() async {
    final requestOrganizationList = await requestOrganization();
    setState(() {
      orgResult = requestOrganizationList;
    });
    getRankText();
  }

  // 기관별 순위 List 형태로 만들기
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
    // 기관별 순위 가져오기
    getOrganizationRank();
    // 사용자 월별 값 가져오기
    getUserPointHistory();
    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    final screenHeight = ScreenSize(context).height;
    final screenWidth = ScreenSize(context).width;
    return AppScaffold(
      title: argument.title,
      body: loading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 사용자 정보
                Container(
                  margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              AuthService.user.photoURL.toString(),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AuthService.user.displayName.toString(),
                                  style: TextStyle(
                                    fontSize: maxFointSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  AuthService.point.toString() == 'null'
                                      ? '0 Point'
                                      : AuthService.point.toString() + " Point",
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: maxFointSize * 0.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 월별 포인트 적립 그래프
                Container(
                  margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RoundedRectangleBorderButton(
                              child: Text(
                                "월별 포인트 적립",
                                style: TextStyle(fontSize: maxFointSize),
                              ),
                              backgroudColor: AppColors.primary,
                              textColor: Colors.white,
                              radius: 10.0,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.9,
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          border: Border.all(
                            width: 3,
                            color: AppColors.primary,
                          ),
                        ),
                        child: Chart(userPointList: userHistoryList),
                      ),
                    ],
                  ),
                ),
                // 기관별 랭킹
                Container(
                  margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            RoundedRectangleBorderButton(
                              child: Text(
                                "전체 기관별 순위",
                                style: TextStyle(fontSize: maxFointSize),
                              ),
                              backgroudColor: AppColors.primary,
                              textColor: Colors.white,
                              radius: 10.0,
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.9,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          border: Border.all(
                            width: 3,
                            color: AppColors.primary,
                          ),
                        ),
                        child: ListView(
                          children: rankText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : CircularProgressIndicator(),
    );
  }
}

/// 월별 그래프
class Chart extends StatelessWidget {
  final List<User> userPointList;
  Chart({Key key, this.userPointList});

  // 포인트 값중 제일 큰 값 찾아내기
  double maxNum() {
    double result = 0.0;
    double point = 0.0;
    for (var i = 0; i < userPointList.length; i++) {
      point = userPointList[i].point.toDouble();
      if (result < point) {
        result = point;
      }
    }
    return result;
  }

  // 월별 포인트 FlSpot List로 만들기
  List<FlSpot> flspot() {
    final listLength = userPointList.length - 1;
    List<FlSpot> result = [];
    for (var i = 0; i < listLength + 1; i++) {
      result.add(
        FlSpot(
          i.toDouble(),
          userPointList[i].point.toDouble(),
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return userPointList == null || userPointList.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : LineChart(
            LineChartData(
              // x, y축 최대 최소 값 정하기
              minX: 0,
              maxX: userPointList.length.toDouble() - 1.0,
              minY: 0,
              maxY: maxNum() + 1.0,
              // 가로선 세로선 그리기
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                drawHorizontalLine: true,
              ),
              lineBarsData: [
                // 그래프 그리기
                LineChartBarData(
                  spots: flspot(), //그래프 값
                  colors: [AppColors.primary, AppColors.primary],
                  barWidth: 2,
                  dotData: FlDotData(show: true),
                  // 아래 색상 채우기
                  belowBarData: BarAreaData(
                    show: true,
                    colors: [
                      AppColors.primary.withOpacity(0.2),
                      AppColors.primary.withOpacity(0.2)
                    ],
                  ),
                ),
              ],
              // 그래프 label 값 설정
              titlesData: FlTitlesData(
                show: true,
                // X축 label
                bottomTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 5,
                  getTextStyles: (value) => TextStyle(
                    color: AppColors.primary,
                    fontSize: minFointSize,
                    fontWeight: FontWeight.bold,
                  ),
                  getTitles: (value) {
                    // 기존 0~ 값 대신 적힐 내용
                    final String date =
                        userPointList[userPointList.length - 1 - value.toInt()]
                            .date;
                    return date.substring(date.length - 2) + "월";
                  },
                ),
                // Y축 label
                leftTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 10,
                  getTextStyles: (value) => TextStyle(
                    color: AppColors.primary,
                    fontSize: minFointSize,
                    fontWeight: FontWeight.bold,
                  ),
                  getTitles: (value) {
                    // 기존 0~ 값 대신 적힐 내용
                    if (maxNum() > 10) {
                      if (value.toInt() % 10 == 5) {
                        return value.toInt().toString() + 'P';
                      } else
                        return '';
                    } else
                      return value.toInt().toString() + 'P';
                  },
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
          fontSize: minFointSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        rankeText.point.toString() + "회",
        style: TextStyle(
          fontSize: minFointSize,
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
                fontSize: minFointSize,
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
