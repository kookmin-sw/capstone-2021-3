import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'version.dart';
import 'login.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPage createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
  bool checkLogIn = false; // 로그인 여부 확인
  var userObj;

  void logInOut(bool check) {
    setState(() {
      checkLogIn = check;
    });
  }

  void getUserObj(var obj) {
    setState(() {
      userObj = obj;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Button(
            text: checkLogIn ? '마이페이지' : '회원가입 / 로그인',
            page: LoginPage(
                logInOut: (bool check) => this.logInOut(check),
                getUserObj: (dynamic obj) => this.getUserObj(obj),
                checkLogIn: checkLogIn,
                userObj: userObj),
            url: ''),
        Button(
          url:
              'https://www.youtube.com/watch?v=y0AfdkAIbP4&ab_channel=%EC%9D%B4%EB%85%B8%EB%B2%84%EC%8A%A4',
          text: '쓰샘 기기 활용법',
        ),
        Button(
          url: 'https://www.inobus.co.kr/',
          text: '이노버스 소개',
        ),
        Button(text: '라이선스 및 버전', page: VersionPage(), url: ''),
      ],
    ));
  }
}

class Button extends StatelessWidget {
  final String text;
  final Widget page;
  final String url;

  Button({Key key, this.text, this.page, this.url}) : super(key: key);

  launchURL() async {
    if (await canLaunch(this.url)) {
      await launch(
        this.url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  goPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      child: ElevatedButton(
          onPressed: () => (this.url == '' ? goPage(context) : launchURL()),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(
                  EdgeInsets.all(screenHeight * 0.05))),
          child: Text(
            this.text,
            style:
                TextStyle(color: Colors.black, fontSize: screenHeight * 0.03),
          )),
    );
  }
}
