import 'package:flutter/material.dart';

class CustomSnackBar {
  CustomSnackBar(BuildContext context, Widget content, Color bgcolor,
      {SnackBarAction? snackBarAction}) {
    final SnackBar snackBar = SnackBar(
        elevation: 30,
        action: snackBarAction,
        backgroundColor: bgcolor,
        content: content,
        behavior: SnackBarBehavior.floating);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class CardWidget extends StatelessWidget {
  final double width;
  final double height;
  final gradient;
  final borderRadius;
  final child;
  final color;
  const CardWidget(
      {super.key,
      this.gradient,
      this.color,
      required this.width,
      required this.height,
      required this.borderRadius,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          border: color == null
              ? gradient == null
                  ? Border.all(color: Colors.red)
                  : null
              : null,
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: gradient == null
              ? null
              : LinearGradient(
                  colors: gradient,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
        ),
        child: child);
  }
}
