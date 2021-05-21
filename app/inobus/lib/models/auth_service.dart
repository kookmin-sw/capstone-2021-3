import 'dart:developer' as developer;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 사용자 정보 관련 클래스
class AuthService {
  static User user;
  static int point;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 구글 로그인
  Future<bool> loginGoogle() async {
    try {
      // Google 인증 흐름을 Trigger 시작
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      // 요청에서 인증 세부 정보를 얻기
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // 새로운 자격 증명 만들기
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // firebase를 구글로 Sign in : 사용자 자격 증명용
      await _auth.signInWithCredential(credential);
      // 유저 정보 firebase에서 가져오기
      user = _auth.currentUser;

      // 정보 확인
      if (user != null) {
        developer.log("Firebase user information verification success");
        developer.log(user.displayName);
        return true;
      } else {
        developer.log("Firebase user information verification fail");
      }
    } catch (err) {
      developer.log("Google Login Fail");
      developer.log(err);
    }
    return false;
  }

// 구글 로그아웃
  void logoutGoogle() {
    try {
      // Google 인증 흐름을 Trigger 해제
      // 샤용자 정보 삭제(탈퇴)
      // user.delete();
      _googleSignIn.signOut();
      _auth.signOut();
      developer.log("Google Logout Success");
    } catch (err) {
      developer.log("Google Logout Fail");
      developer.log(err);
    }
  }
}
