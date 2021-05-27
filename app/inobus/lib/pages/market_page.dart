import 'package:flutter/material.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/widgets/app_scaffold.dart';

/// 마켓
class MarketPage extends StatefulWidget {
  @override
  _MarketPage createState() => _MarketPage();
}

class _MarketPage extends State<MarketPage> {
  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    return AppScaffold(
      title: argument.title,
      body: Center(child: Text("준비중입니다.")),
    );
  }
}
