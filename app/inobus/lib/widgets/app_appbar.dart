import 'package:flutter/material.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/app_icons.dart';

class AppAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool isMainScreen;

  final String defaultTitle = "INOBUS";

  const AppAppBar({
    Key key,
    this.title,
    this.isMainScreen,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget buildDefaultTitle(BuildContext context) {
    return Text(
      defaultTitle,
      style: Theme.of(context).textTheme.headline1,
    );
  }

  Widget buildTitle(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline2.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildLeadingButton(BuildContext context, bool isMainScreen) {
    Image icon;
    VoidCallback onTap;
    if (isMainScreen) {
      icon = AppIcons.menu.icon();
      onTap = () {
        // 메뉴 클릭시 Drawer 메뉴 열기
        Scaffold.of(context).openDrawer();
      };
    } else {
      icon = AppIcons.arrow.icon();
      onTap = () {
        // 처음 화면까지 Route 비우기
        Navigator.popUntil(context, (route) => route.isFirst);
      };
    }

    return Container(
      padding: EdgeInsets.zero,
      alignment: Alignment.bottomRight,
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(child: icon, onTap: onTap),
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context, bool isMainScreen) {
    if (isMainScreen) {
      return Container();
    } else {
      Image icon = AppIcons.home.icon();
      VoidCallback onTap = () {
        // 처음 화면까지 Route 비우기
        Navigator.maybePop(context);
      };
      return Container(
        padding: EdgeInsets.zero,
        alignment: Alignment.bottomRight,
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(child: icon, onTap: onTap),
          ),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    final isMainScreen = title == null;

    return AppBar(
      title: isMainScreen ? buildDefaultTitle(context) : buildTitle(context),
      leading: _buildLeadingButton(context, isMainScreen),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      actions: [
        _buildActions(context, isMainScreen),
      ],
    );
  }
}
