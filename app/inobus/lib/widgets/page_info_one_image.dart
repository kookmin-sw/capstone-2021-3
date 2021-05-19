import 'package:flutter/material.dart';

class PageInforamtionOneImage extends StatelessWidget {
  final Image mainImg;
  final TextSpan textList;

  PageInforamtionOneImage({this.mainImg, this.textList});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Stack(
      children: [
        Align(
          alignment: Alignment(0.0, -0.65),
          child: Container(
            child: mainImg,
            height: screenHeight * 0.4,
          ),
        ),
        Align(
          alignment: Alignment(0.0, 0.7), // (가로, 세로)
          child: RichText(
            textAlign: TextAlign.center,
            text: textList,
          ),
        ),
      ],
    );
  }
}
