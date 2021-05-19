import 'package:flutter/material.dart';
import 'package:inobus/routes.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/widgets/app_scaffold.dart';

/// 이용안내
class InformationPage extends StatefulWidget {
  @override
  _InformationPage createState() => _InformationPage();
}

class _InformationPage extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    return AppScaffold(
      title: argument.title,
      body: Expanded(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0.0, -0.2),
              child: MaterialButton(
                child: Text("기기이용안내"),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.infoExplan,
                    arguments: RouteArgument(
                      title: "이용안내",
                      selectList: 0, // 0: 기기 사용법, 1: 추첨권 사용법 설명
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.2),
              child: MaterialButton(
                child: Text("추첨권 발급 및 이용방법"),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.infoExplan,
                    arguments: RouteArgument(
                      title: "이용안내",
                      selectList: 1, // 0: 기기 사용법, 1: 추첨권 사용법 설명
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
