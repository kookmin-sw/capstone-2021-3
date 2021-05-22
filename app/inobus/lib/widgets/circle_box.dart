import 'package:flutter/material.dart';

class RoundedRectangleBorderBox extends StatelessWidget {
  RoundedRectangleBorderBox(
      {Key key,
      this.child,
      this.height,
      this.width,
      this.backgroudColor,
      this.radius,
      this.padding});

  final double height;
  final double width;
  final double radius;
  final double padding;
  final Color backgroudColor;
  final child;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(padding == null ? 0 : padding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroudColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: child);
  }
}

class OutlineRoundedRectangleBorderBox extends StatelessWidget {
  OutlineRoundedRectangleBorderBox({
    Key key,
    this.child,
    this.height,
    this.width,
    this.padding,
    this.sidmargin,
    this.bordercolor,
    this.borderwidth,
    this.radius,
  });

  final double height;
  final double width;
  final double radius;
  final double padding;
  final double sidmargin;
  final double borderwidth;
  final Color bordercolor;
  final child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding == null ? 0 : padding),
      margin: sidmargin == null
          ? EdgeInsets.all(0)
          : EdgeInsets.only(
              left: sidmargin,
              right: sidmargin,
            ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        border: Border.all(
          width: borderwidth,
          color: bordercolor,
        ),
      ),
      child: child,
    );
  }
}

class OutlineCircleBox extends StatelessWidget {
  OutlineCircleBox({
    Key key,
    this.child,
    this.radius,
    this.padding,
    this.borderwidth,
    this.fillcolor,
    this.bordercolor,
  });

  final double radius;
  final double borderwidth;
  final double padding;
  final Color fillcolor;
  final Color bordercolor;
  final child;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: radius * 2,
        width: radius * 2,
        padding: EdgeInsets.all(padding == null ? 0 : padding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: fillcolor,
          shape: BoxShape.circle,
          border: Border.all(
            color: bordercolor,
            width: borderwidth,
          ),
        ),
        child: child);
  }
}

class CircleBox extends StatelessWidget {
  CircleBox({
    Key key,
    this.child,
    this.radius,
    this.padding,
    this.fillcolor,
  });

  final double radius;
  final double padding;
  final Color fillcolor;
  final child;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: radius * 2,
        width: radius * 2,
        padding: EdgeInsets.all(padding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: fillcolor,
          shape: BoxShape.circle,
        ),
        child: child);
  }
}
