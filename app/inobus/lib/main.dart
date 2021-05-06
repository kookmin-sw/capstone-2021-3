import 'package:flutter/material.dart';
import 'package:inobus/app_theme.dart';
import 'package:inobus/routes.dart';

void main() {
  runApp(InobusApp());
}

class InobusApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "INOBUS",
      initialRoute: Routes.map,
      onGenerateRoute: Routes.onGenerateRoute,
      theme: appTheme,
    );
  }
}
