import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:inobus/routes.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/widgets/app_scaffold.dart';
import 'package:inobus/models/auth_service.dart';

/// 설정 페이지
class SettingPage extends StatefulWidget {
  SettingPage({Key key});
  @override
  _SettingPage createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  String version = 'null';

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  void initState() {
    super.initState();
    getAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    return AppScaffold(
      title: argument.title,
      body: Column(
        children: [
          UnderLineButton(
            mainText: "버전 " + version,
            endText: "최신버전",
            padding: 5.0,
          ),
          UnderLineButton(
            mainText: "로그아웃",
            padding: 5.0,
          ),
        ],
      ),
    );
  }
}

class UnderLineButton extends StatelessWidget {
  final String mainText;
  final String endText;
  final double padding;

  UnderLineButton({Key key, this.mainText, this.endText, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0),
          ),
        ),
        child: MaterialButton(
          onPressed: () {
            if (mainText == '로그아웃') {
              AuthService().logoutGoogle();
              Navigator.pushNamed(context, Routes.intro);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                mainText,
                style: TextStyle(fontSize: 17),
              ),
              Text(
                endText == null ? "" : endText,
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
