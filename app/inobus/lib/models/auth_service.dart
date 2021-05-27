import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inobus/api/api.dart';

/// 사용자 정보 관련 클래스
class AuthService {
  static User user;
  static int ticket;
  static int point;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //애플 로그인
  Future<bool> loginApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await _auth.signInWithCredential(oauthCredential);
      user = _auth.currentUser;

      // 정보 확인
      if (user != null) {
        developer.log("Firebase user information verification success");
        developer.log(user.displayName.toString());
        // 유저 포인트 가져오기
        requesttUserPoint();
        return true;
      } else {
        developer.log("Firebase user information verification fail");
      }
    } catch (err) {
      developer.log("Google Login Fail");
      developer.log(err.toString());
    }
    return false;
  }

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
        developer.log(user.displayName.toString());
        // 유저 정보 가져오기
        requesttUserPoint();
        requesttUserTicket();
        return true;
      } else {
        developer.log("Firebase user information verification fail");
      }
    } catch (err) {
      developer.log("Google Login Fail");
      developer.log(err.toString());
    }
    return false;
  }

  //로그아웃
  void logout() {
    try {
      // 탈퇴
      // user.delete();
      // 사용자 정보 삭제
      user = null;
      // Google 인증 흐름을 Trigger 해제
      _googleSignIn.signOut();
      _auth.signOut();
      developer.log("Logout Success");
    } catch (err) {
      developer.log("Logout Fail");
      developer.log(err.toString());
    }
  }

  // 사용자 포인트 값 가져오기
  void requesttUserPoint() async {
    String url = ApiUrl().getUserUrl(user.uid.toString());
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes); //String
      final data = json.decode(responseBody); //json
      
      point = data["point"];
    } else {
      point = 0;
      developer.log("Can not access API");
      developer.log(response.statusCode.toString());
    }
  }

  // 사용자 티켓개수 가져오기
  void requesttUserTicket() async {
    String url = ApiUrl().getUserTicketsUrl(user.uid.toString());
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes); //String
      final data = json.decode(responseBody); //json

      ticket = data["ticket"];
    } else {
      point = 0;
      developer.log("Can not access API");
      developer.log(response.statusCode.toString());
    }
  }
}
