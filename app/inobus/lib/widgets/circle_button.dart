import 'package:flutter/material.dart';

class OutlineCircleButton extends StatelessWidget {
  OutlineCircleButton({
    Key key,
    this.onPressed,
    this.borderSize: 0.5,
    this.radius: 20.0,
    this.borderColor: Colors.black,
    this.foregroundColor: Colors.white,
    this.child,
  }) : super(key: key);

  final onPressed;
  final double radius;
  final double borderSize;
  final borderColor;
  final foregroundColor;
  final child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderSize),
          color: foregroundColor,
          shape: BoxShape.circle,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: child ?? SizedBox(),
            onTap: () async {
              if (onPressed != null) {
                onPressed();
              }
            },
          ),
        ),
      ),
    );
  }
}

class RoundedRectangleBorderButton extends StatelessWidget {
  RoundedRectangleBorderButton({
    Key key,
    this.onPressed,
    this.padding: 10.0,
    this.radius: 50.0,
    this.backgroudColor: Colors.white,
    this.textColor: Colors.black,
    this.child,
  }) : super(key: key);

  final onPressed;
  final double radius;
  final double padding;
  final backgroudColor;
  final textColor;
  final child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: child,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(padding),
        primary: backgroudColor,
        onPrimary: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
