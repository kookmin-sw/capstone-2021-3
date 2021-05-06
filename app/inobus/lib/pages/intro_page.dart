import 'package:flutter/material.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/widgets/app_scaffold.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    return AppScaffold(
      title: argument.title,
      body: Center(
        child: Text(argument.title),
      ),
    );
  }
}
