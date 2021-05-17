import 'dart:developer' as developer;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:barcode_widget/barcode_widget.dart';

/// 사용자 정보
class UserObj {
  static String id;
  static String name;
  static int point;
  static BarcodeWidget barcod = BarcodeWidget(
    data: id,
    barcode: Barcode.code128(),
    drawText: false,
  );

  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static final FirebaseAuth auth = FirebaseAuth.instance;
}

// 구글 로그인
void loginGoogle() async {
  try {
    // Google 인증 흐름을 Trigger 시작
    final GoogleSignInAccount googleUser = await UserObj.googleSignIn.signIn();
    // 요청에서 인증 세부 정보를 얻기
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    // 새로운 자격 증명 만들기
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // firebase를 구글로 Sign in : 사용자 자격 증명용
    await UserObj.auth.signInWithCredential(credential);
    // 유저 정보 firebase에서 가져오기
    UserObj.id = UserObj.auth.currentUser.uid;
    UserObj.name = UserObj.auth.currentUser.displayName;

    // 정보 확인
    if (UserObj.id != null) {
      developer.log("Firebase user information verification success");
      developer.log(UserObj.name);
    } else {
      print("Firebase user information verification fail");
    }
  } catch (err) {
    developer.log("Google Login Fail");
    developer.log(err);
  }
}

// 구글 로그아웃
void logoutGoogle() {
  try {
    // Google 인증 흐름을 Trigger 해제
    UserObj.googleSignIn.signOut();
    developer.log("Google Logout Success");
  } catch (err) {
    developer.log("Google Logout Fail");
    developer.log(err);
  }
}
