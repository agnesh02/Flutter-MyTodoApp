import 'package:flutter/material.dart';

class AppStyle {
  static const textFieldHeadingStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static TextStyle strikeThroughStyle(bool isCompleted) {
    return TextStyle(
      decoration:
          isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }
}
