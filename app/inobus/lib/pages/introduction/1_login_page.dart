import 'package:flutter/material.dart';
import 'package:inobus/app_images.dart';
import 'package:inobus/widgets/login_button.dart';
import 'package:inobus/models/auth_service.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback onNextPage;

  LoginPage({Key key, this.onNextPage});

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
              logoloc: AppImages.googleLogo.path,
              outlinecolor: Color(0xff5234eb),
              onpress: () {
                // 로그인을 확인하면 다음 페이지로 넘어가기
                AuthService().loginGoogle().then((value) => onNextPage());
              },
              text: "구글 로그인",
            ),
          ),
          Positioned(
            top: screenHeight * 0.7,
            child: LoginButtton(
              logoloc: AppImages.appleLogo.path,
              outlinecolor: Color(0xff5234eb),
              onpress: onNextPage,
              text: "애플 로그인",
            ),
          ),
        ],
      ),
    );
  }
}
