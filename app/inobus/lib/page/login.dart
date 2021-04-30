import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../frame/loginbutton.dart';

class LoginPage extends StatefulWidget {
  LoginPage();
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  loginGoogle() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _userObj = _googleSignIn.currentUser;
        if (_userObj != null) {
          _isLoggedIn = true;
        }
      });
    } catch (err) {
      print(err);
    }
  }

  logoutGoogle() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Log In")),
      body: Container(
        child: _isLoggedIn
            ? Center(
                child: Column(
                children: <Widget>[
                  Image.network(_userObj.photoUrl),
                  Text(_userObj.displayName),
                  Text(_userObj.email),
                  Text(_userObj.id),
                  ElevatedButton(
                      onPressed: () {
                        logoutGoogle();
                      },
                      child: Text("Logout"))
                ],
              ))
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/logo_horizontal_black.png',
                    width: screenSize.width * 0.7,
                  ),
                  LoginButtton(
                      text: "Google 계정으로 로그인",
                      logoloc: 'assets/image/google_logo_icon.png',
                      outlinecolor: Colors.red,
                      onpress: () => loginGoogle()),
                ],
              )),
      ),
    );
  }
}
