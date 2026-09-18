import 'package:flutter/material.dart';
import 'package:todolist/core/style/color_manger.dart';
import 'package:todolist/core/style/text_style.dart';
import 'package:todolist/core/utils/units.dart';

class OnboardingTab extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingTab({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(image),
            Container(
              height: Units.getHeight(context: context, widgetHeight: 208),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    ColorsManager.whiteColor,
                    ColorsManager.whiteColor,
                    ColorsManager.whiteColor.withAlpha(0),
                  ],
                ), // LinearGradient
              ), // BoxDecoration
            ), // Container
            Text(
              title,
              style: TextStyles.textStyleBlackSB26,
              textAlign: TextAlign.center,
            ), // Text
          ],
        ), // Stack
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyles.textStyleNeutralSecondaryR14,
        ), // Text
      ],
    ); // Column
  }
}
