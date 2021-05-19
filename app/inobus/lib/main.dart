import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inobus/app_theme.dart';
import 'package:inobus/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(InobusApp());
}

class InobusApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "INOBUS",
      initialRoute: Routes.initialRoute,
      onGenerateRoute: Routes.onGenerateRoute,
      theme: appTheme,
    );
  }
}
