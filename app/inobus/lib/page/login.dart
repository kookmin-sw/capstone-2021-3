import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../frame/loginbutton.dart';

class LoginPage extends StatefulWidget {
  final Function(dynamic) getUserObj;
  final bool checkLogIn;
  final userObj;
  LoginPage({Key key, this.userObj, this.checkLogIn, this.getUserObj});
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool isLoggedIn = false;
  User userObj;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  // GoogleSignInAccount userObj;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoggedIn = widget.checkLogIn;
      userObj = widget.userObj;
    });
  }

  loginGoogle() async {
    try {
      // Trigger the Google Authentication flow.
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      // Obtain the auth details from the request.
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // Create a new credential.
      final GoogleAuthCredential googleCredential =
          GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Sign in to Firebase with the Google [UserCredential].
      final UserCredential googleUserCredential =
          await FirebaseAuth.instance.signInWithCredential(googleCredential);

      setState(() {
        // userObj = googleSignIn.currentUser;
        userObj = googleUserCredential.user;
        if (userObj != null) {
          isLoggedIn = true;
          if (isLoggedIn) {
            widget.getUserObj(userObj);
          }
        }
      });
    } catch (err) {
      print(err);
    }
  }

  logoutGoogle() {
    googleSignIn.signOut();
    setState(() {
      isLoggedIn = false;
      userObj = null;
      if (!isLoggedIn) {
        widget.getUserObj(userObj);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Log In")),
      body: Container(
        child: isLoggedIn
            ? Center(
                child: Column(
                children: <Widget>[
                  Text(userObj.displayName),
                  Text(userObj.email),
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
