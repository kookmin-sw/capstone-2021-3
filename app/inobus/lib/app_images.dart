import 'package:flutter/material.dart';

class AppImagePath {
  final String path;
  AppImagePath(this.path);

  @override
  String toString() {
    return path;
  }

  Image image() {
    return Image(image: AssetImage(path));
  }
}

/// App Icon assets path 제공
class AppImages {
  static final drawerSeed = AppImagePath("assets/images/drawer_seed.png");
  static final hero = AppImagePath("assets/images/hero.png");

  // Login button에 사용할 로고
  static final appleLoggo = AppImagePath("assets/images/apple_loggo.png");
  static final googleLoggo = AppImagePath("assets/images/google_loggo.png");
}
