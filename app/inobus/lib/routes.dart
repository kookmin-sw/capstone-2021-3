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
  // 이용안내 설명
  static const infoExplan = '/infoExplain';
  // 이용내역
  static const history = '/history';
  // 공지사항
  static const notice = '/notice';
  // 고객지원
  static const support = '/support';
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
            return UseHistoryPage();
          case Routes.infoExplan:
            return ExplanMain();
          case Routes.map:
          default:
            return MapPage();
        }
      },
    );
  }
}
