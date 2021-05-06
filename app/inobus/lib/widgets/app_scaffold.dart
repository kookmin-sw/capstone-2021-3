import 'package:flutter/material.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/widgets/app_appbar.dart';
import 'package:inobus/widgets/app_drawer.dart';

class AppScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final String title;
  final Widget body;

  AppScaffold({
    this.title,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    final isMainScreen = title == null;

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppAppBar(
        title: title,
      ),
      body: Column(
        children: [
          isMainScreen
              ? Container()
              : Divider(
                  color: AppColors.primary,
                  thickness: 2,
                ),
          body ?? SizedBox(),
        ],
      ),
    );
  }
}
