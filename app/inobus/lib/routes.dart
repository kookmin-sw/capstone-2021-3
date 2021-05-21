import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:inobus/pages/pages.dart';

class Routes {
  // introduction
  static const intro = '/intro';
  // 에코마켓
  static const point = '/point';
  // 에코마켓
  static const market = '/market';
  // 이용안내
  static const information = '/information';
  // 이용내역
  static const history = '/history';
  // 공지사항
  static const notice = '/notice';
  // 고객지원
  static const support = '/support';
  static const support_faq = '/support/faq';
  static const support_privacy_policy = '/support/privacy_policy';
  static const support_terms_of_service = '/support/terms_of_service';
  // 설정
  static const setting = '/setting';
  // 지도
  static const map = '/map';
  // 바코드
  static const barcode = '/barcode';

  // 첫 페이지
  static const initialRoute = intro;

  // Route builder : Animation 변경 가능
  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }

  static Route onGenerateRoute(RouteSettings settings) {
    return Routes.fadeThrough(
      settings,
      (context) {
        print(settings);
        switch (settings.name) {
          case Routes.intro:
            return IntroductionPage();
          case Routes.point:
            return PointPage();
          case Routes.setting:
            return SettingPage();
          case Routes.barcode:
            return BarcodePage();
          case Routes.information:
            return InformationPage();
          case Routes.history:
            return UserHistoryPage();
          case Routes.support:
            return SupportPage();
          case Routes.support_faq:
            return FaqPage();
          case Routes.support_privacy_policy:
            return PrivacyPolicyPage();
          case Routes.support_terms_of_service:
            return TermsOfServicePage();
          case Routes.map:
          default:
            return MapPage();
        }
      },
    );
  }
}
