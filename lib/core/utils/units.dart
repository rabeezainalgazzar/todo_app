import 'package:flutter/material.dart';

class Units {
  static const figmaWidth = 390;
  static const figmaHeight = 812;

  static double getWidth({
    required BuildContext context,
    required double widgetWidth,
  }) => (MediaQuery.of(context).size.width * widgetWidth) / figmaWidth;

  static double getHeight({
    required BuildContext context,
    required double widgetHeight,
  }) => (MediaQuery.of(context).size.height * widgetHeight) / figmaHeight;
}
