import 'package:flutter/material.dart';
import 'loginbutton.dart';
import 'afterLogin.dart';

class LoginSNSPage extends StatefulWidget {
  LoginSNSPage({Key key});
  @override
  _LoginSNSPage createState() => _LoginSNSPage();
}

class _LoginSNSPage extends State<LoginSNSPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: screenHeight * 0.3,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: '제대로 버리면 \n',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 40,
                    ),
                  ),
                  TextSpan(
                    text: "자원",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 40,
                    ),
                  ),
                  TextSpan(
                    text: "이다",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.6,
            child: LoginButtton(
              logoloc: "assets/logo/google_logo_icon.png",
              outlinecolor: Color(0xff5234eb),
              onpress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AfterLoginPage()),
                );
              },
              text: "구글 로그인",
            ),
          ),
          Positioned(
            top: screenHeight * 0.7,
            child: LoginButtton(
              logoloc: "assets/logo/apple_logo_icon.png",
              outlinecolor: Color(0xff5234eb),
              onpress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AfterLoginPage()),
                );
              },
              text: "애플 로그인",
            ),
          ),
        ],
      ),
    );
  }
}
