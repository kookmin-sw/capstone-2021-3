import 'package:flutter/material.dart';
import 'package:inobus/pages/introduction/1_login_page.dart';
import 'package:inobus/pages/introduction/2_after_login_page.dart';
import 'package:inobus/routes.dart';

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pageController = PageController(initialPage: 0);

    final onNextPage = (int page) {
      return () => _pageController.animateToPage(
            page,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
    };

    return PageView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      allowImplicitScrolling: false,
      controller: _pageController,
      children: [
        LoginPage(onNextPage: onNextPage(1)),
        AfterLoginPage(
          onNextPage: () => Navigator.pushNamed(context, Routes.map),
        ),
      ],
    );
  }
}
