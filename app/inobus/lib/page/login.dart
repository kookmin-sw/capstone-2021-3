import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  LoginPage();
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
        _userObj = _googleSignIn.currentUser;
      });
    } catch (err) {
      print(err);
    }
  }

  logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  ElevatedButton(
                      onPressed: () {
                        logout();
                      },
                      child: Text("Logout"))
                ],
              ))
            : Center(
                child: OutlinedButton.icon(
                label: Text("Login with Google"),
                onPressed: () {
                  login();
                },
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                ),
              )),
      ),
    );
  }
}
