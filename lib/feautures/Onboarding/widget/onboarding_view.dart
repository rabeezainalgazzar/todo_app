import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todolist/core/navigation/routes.dart';
import 'package:todolist/core/shared/custom_main_button.dart';
import 'package:todolist/core/shared/custom_text_button.dart';
import 'package:todolist/core/style/assets_manger.dart';
import 'package:todolist/core/style/color_manger.dart';
import 'package:todolist/core/style/text_style.dart';
import 'package:todolist/core/utils/units.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: Units.getHeight(context: context, widgetHeight: 68),
            left: 20,
            right: 20,
          ),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: CustomTextButton(
                    onPressed: () => context.pushNamed(Routes.kWelcomeView),
                    btnTitle: 'Skip',
                  ),
                ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 52),
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(AssetsManager.onboardingOneImage),
                    Container(
                      height: Units.getHeight(
                        context: context,
                        widgetHeight: 200,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            ColorsManager.whiteColor,
                            ColorsManager.whiteColor,
                            ColorsManager.whiteColor.withAlpha(0),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'Your convenience in \nmaking a todo list',
                      style: TextStyles.textStyleBlackSB26,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Text(
                  'Here\'s a mobile platform that helps you create task\nfor list so that it can help you in every job\neasier and faster.',
                  textAlign: TextAlign.center,
                  style: TextStyles.textStyleNeutralSecondaryR14,
                ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 32),
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 2,
                    effect: ExpandingDotsEffect(
                      activeDotColor: ColorsManager.brandPrimaryLightColor,
                      dotColor: ColorsManager.neutralLineColor,
                      dotHeight: Units.getHeight(
                        context: context,
                        widgetHeight: 8,
                      ),
                      dotWidth: Units.getWidth(
                        context: context,
                        widgetWidth: 8,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 40),
                ),
                CustomMainButton(
                  btnTitle: 'Continue',
                  onPressed: () => context.pushNamed(Routes.kWelcomeView),
                ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
