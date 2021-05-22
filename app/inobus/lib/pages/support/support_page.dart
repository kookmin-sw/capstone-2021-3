import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/pages/support/widgets/support_footer.dart';
import 'package:inobus/pages/support/widgets/support_title.dart';
import 'package:inobus/routes.dart';
import 'package:inobus/widgets/app_scaffold.dart';

class SupportMenu {
  final String name;
  final VoidCallback onTap;

  SupportMenu(this.name, this.onTap);
}

class SupportPage extends StatelessWidget {
  final contentpadding = const EdgeInsets.all(0.5);

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  List<SupportMenu> getMenuList(BuildContext context, RouteArgument argument) {
    return [
      SupportMenu(
        "FAQ",
        () => Navigator.pushNamed(
          context,
          Routes.support_faq,
          arguments: argument,
        ),
      ), // faq_page.dart
      SupportMenu("Q&A\n게시판", () {}), // TODO:대체할 서비스 결정 후 연결
      SupportMenu("고장 및 신고", () {
        launchURL("https://open.kakao.com/o/gf3SgGed");
      }), // TODO:Google form url 연결
      SupportMenu(
        "서비스\n이용약관",
        () => Navigator.pushNamed(
          context,
          Routes.support_terms_of_service,
          arguments: argument,
        ),
      ),
      SupportMenu(
        "개인정보\n처리방침",
        () => Navigator.pushNamed(
          context,
          Routes.support_privacy_policy,
          arguments: argument,
        ),
      ), // privacy_policy_page.dart // terms_of_service_page.dart
    ];
  }

  Widget _buildMenuGridItem(SupportMenu menuItem) {
    return Material(
      color: Colors.white.withOpacity(0.0),
      child: InkWell(
        onTap: menuItem.onTap,
        child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Text(
            menuItem.name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context, List<SupportMenu> menus) {
    final paddingValue = 1.0;

    return Center(
      child: Container(
        color: Colors.black87,
        width: MediaQuery.of(context).size.width * 0.8,
        child: StaggeredGridView.countBuilder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            top: paddingValue,
            left: paddingValue,
            right: paddingValue,
          ),
          shrinkWrap: true,
          itemCount: menus.length,
          crossAxisCount: 6,
          itemBuilder: (context, index) {
            return _buildMenuGridItem(menus[index]);
          },
          staggeredTileBuilder: (index) {
            if (index < 2) {
              return StaggeredTile.count(3, 1.5);
            }
            return StaggeredTile.count(2, 2);
          },
          crossAxisSpacing: paddingValue,
          mainAxisSpacing: paddingValue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    final menus = getMenuList(context, argument);

    return AppScaffold(
      title: argument.title,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      body: Expanded(
        child: Column(
          children: [
            SupportTitle('무엇을 도와드릴까요?'),
            _buildMenuGrid(context, menus),
            Spacer(),
            SupportFooter(),
          ],
        ),
      ),
    );
  }
}
