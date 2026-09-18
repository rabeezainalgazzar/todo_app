import 'package:flutter/material.dart';

import 'package:todolist/core/style/color_manger.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String btnTitle;
  final double? fontSize;
  final Color? btnColor;
  final FontWeight? fontWeight;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.btnTitle,
    this.fontSize,
    this.fontWeight,
    this.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        btnTitle,
        style: TextStyle(
          color: btnColor ?? ColorsManager.brandPrimaryLightColor,
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.w500,
        ), // TextStyle
      ), // Text
    ); // TextButton
  }
}
