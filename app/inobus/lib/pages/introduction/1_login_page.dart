import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:inobus/app_images.dart';
import 'package:inobus/routes.dart';
import 'package:inobus/widgets/login_button.dart';
import 'package:inobus/models/auth_service.dart';
import 'package:inobus/app_colors.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback onNextPage;

  LoginPage({Key key, this.onNextPage});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return SafeArea(
      child: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
            content: Text('뒤로 가기를 1번 더 누르면 종료 됩니다.'),
          ),
          child: Stack(
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
              // 구글 로그인 버튼
              Positioned(
                top: screenHeight * 0.6,
                child: LoginButtton(
                  logoloc: AppImages.googleLogo.path,
                  outlinecolor: AppColors.primary,
                  text: "구글 로그인",
                  onpress: () {
                    // 로그인을 확인하면 다음 페이지로 넘어가기
                    // 로그인 불가시 로그인 불가 메세지 띄우기
                    AuthService().loginGoogle().then((check) => check
                        ? Navigator.pushNamed(context, Routes.intro_welcome)
                        : showAlertDialog(context));
                  },
                ),
              ),
              if (Platform.isIOS)
                Positioned(
                  top: screenHeight * 0.7,
                  child: LoginButtton(
                    logoloc: AppImages.appleLogo.path,
                    outlinecolor: AppColors.primary,
                    text: "애플 로그인",
                    onpress: () {
                      // 로그인을 확인하면 다음 페이지로 넘어가기
                      // 로그인 불가시 로그인 불가 메세지 띄우기
                      AuthService().loginApple().then((check) => check
                          ? Navigator.pushNamed(context, Routes.intro_welcome)
                          : showAlertDialog(context));
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그인 실패'),
          content: Text("로그인이 실패하였습니다.\n다른 아이디로 실행해 주세요."),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, "Cancel");
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        );
      },
    );
  }
}
