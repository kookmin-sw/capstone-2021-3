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
}
