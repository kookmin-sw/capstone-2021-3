import 'package:flutter/material.dart';

/// 로그인 버튼 만들기
class LoginButtton extends StatefulWidget {
  final String text;
  final String logoloc;
  final Color outlinecolor;
  final VoidCallback onpress;

  const LoginButtton(
      {Key key, this.text, this.logoloc, this.outlinecolor, this.onpress});

  @override
  _LoginButtton createState() => _LoginButtton();
}

class _LoginButtton extends State<LoginButtton> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.7,
      height: screenSize.width * 0.7 * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2,
          color: widget.outlinecolor,
          style: BorderStyle.solid,
        ),
      ),
      child: TextButton(
        onPressed: widget.onpress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              widget.logoloc,
              width: screenSize.width * 0.7 * 0.2 * 0.5,
            ),
            Text(
              widget.text,
              style: TextStyle(
                  fontSize: screenSize.width * 0.7 * 0.2 * 0.3,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
