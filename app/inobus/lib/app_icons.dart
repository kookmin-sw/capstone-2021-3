import 'package:flutter/material.dart';

class AppIconPath {
  final String path;
  AppIconPath(this.path);

  @override
  String toString() {
    return path;
  }

  Image icon({double width, double height}) {
    return Image(
      image: AssetImage(path),
      width: width,
      height: height,
    );
  }
}

/// App Icon assets path 제공
class AppIcons {
  static final arrow = AppIconPath("assets/icons/arrow.png");
  static final bell = AppIconPath("assets/icons/bell.png");
  static final block = AppIconPath("assets/icons/block.png");
  static final cart = AppIconPath("assets/icons/cart.png");
  static final checkbox = AppIconPath("assets/icons/checkbox.png");
  static final document = AppIconPath("assets/icons/document.png");
  static final gear = AppIconPath("assets/icons/gear.png");
  static final graph = AppIconPath("assets/icons/graph.png");
  static final headset = AppIconPath("assets/icons/headset.png");
  static final home = AppIconPath("assets/icons/home.png");
  static final money = AppIconPath("assets/icons/money.png");
  static final menu = AppIconPath("assets/icons/menu.png");
  static final pin = AppIconPath("assets/icons/pin.png");
  static final play = AppIconPath("assets/icons/play.png");
  static final speechBubble = AppIconPath("assets/icons/speech_bubble.png");
}
