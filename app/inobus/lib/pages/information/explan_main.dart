import 'package:flutter/material.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/widgets/app_scaffold.dart';
import 'package:inobus/pages/information/use_barcode.dart';
import 'package:inobus/pages/information/use_lottery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// 이용안내 설명 페이지
class ExplanMain extends StatefulWidget {
  @override
  _ExplanMain createState() => _ExplanMain();
}

class _ExplanMain extends State<ExplanMain> {
  int selectedIndex = 0;
  PageController pagecontroller;
  final List<Widget> useDevicePageList = [
    BarcodeFirstPage(),
    BarcodeSecondPage(),
    BarcodeThirdPage(),
  ];
  final List<Widget> useAppPageList = [
    LotteryFirstPage(),
    LotterySecondPage(),
  ];

  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pagecontroller = PageController(
      initialPage: selectedIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    return AppScaffold(
      title: argument.title,
      body: Expanded(
        child: Stack(
          children: <Widget>[
            PageView(
              controller: pagecontroller,
              scrollDirection: Axis.horizontal,
              // 0:기기사용법, 1:추첨권사용법
              children:
                  argument.selectList == 0 ? useDevicePageList : useAppPageList,
            ),
            Align(
              // 현재 페이지 표시 indexing 이미지
              alignment: Alignment(0.0, 0.9),
              child: Container(
                child: SmoothPageIndicator(
                  controller: pagecontroller,
                  // 0:기기사용법, 1:추첨권사용법
                  count: argument.selectList == 0
                      ? useDevicePageList.length
                      : useAppPageList.length,
                  axisDirection: Axis.horizontal,
                  effect: WormEffect(
                      dotColor: Colors.grey.withOpacity(.60),
                      activeDotColor: AppColors.primary),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
