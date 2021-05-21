import 'package:flutter/material.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/app_icons.dart';
import 'package:inobus/app_images.dart';
import 'package:inobus/routes.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/models/auth_service.dart';

class DrawerItem {
  final Image icon;
  final String title;
  final String route;

  DrawerItem(this.icon, this.title, this.route);
}

class AppDrawer extends StatelessWidget {
  final drawerItems = [
    DrawerItem(AppIcons.money.icon(), "추첨권/포인트", Routes.point),
    DrawerItem(AppIcons.document.icon(), "이용안내", Routes.information),
    DrawerItem(AppIcons.graph.icon(), "이용내역", Routes.history),
    DrawerItem(AppIcons.headset.icon(), "고객지원", Routes.support),
    DrawerItem(AppIcons.gear.icon(), "설정", Routes.setting),
  ];

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: DrawerHeader(
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColors.primary,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.drawerSeed.path),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                '씨앗 등급',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white),
              ),
              Text(
                AuthService.user.displayName + '님',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white),
              ),
            ],
          )),
    );
  }

  Widget _buildDrawerItem(BuildContext context, DrawerItem item) {
    return ListTile(
      dense: true,
      leading: item.icon,
      title: Text(
        item.title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, item.route,
            arguments: RouteArgument(title: item.title));
      },
    );
  }

  List<Widget> _buildDrawerItems(BuildContext context) {
    return List<Widget>.generate(
      drawerItems.length,
      (index) => _buildDrawerItem(context, drawerItems[index]),
    );
  }

  Widget _buildDrawerFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      height: MediaQuery.of(context).size.height * 0.08,
      color: Colors.black12,
      alignment: Alignment.bottomRight,
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: AppIcons.arrow.icon(),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: <Widget>[
                _buildDrawerHeader(context),
                SizedBox(height: 24),
                ..._buildDrawerItems(context),
              ],
            ),
            Spacer(),
            _buildDrawerFooter(context),
          ],
        ),
      ),
    );
  }
}
