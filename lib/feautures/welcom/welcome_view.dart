import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/navigation/routes.dart';
import 'package:todolist/core/shared/custom_main_button.dart';
import 'package:todolist/core/style/assets_manger.dart';
import 'package:todolist/core/style/color_manger.dart';
import 'package:todolist/core/style/custom_font_weight.dart';
import 'package:todolist/core/style/text_style.dart';
import 'package:todolist/core/utils/units.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: Units.getHeight(context: context, widgetHeight: 40),
              ),
              _buildHeading(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Units.getHeight(
                      context: context,
                      widgetHeight: 20,
                    ),
                  ),
                  child: Image.asset(
                    AssetsManager.welcomeImage,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              CustomMainButton(
                btnTitle: 'Continue with email',
                onPressed: () => context.pushNamed(Routes.kLoginView),
                customContent: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetsManager.messageIcon,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        ColorsManager.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(
                      width: Units.getWidth(context: context, widgetWidth: 10),
                    ),
                    Text(
                      'Continue with email',
                      style: TextStyle(
                        color: ColorsManager.whiteColor,
                        fontSize: 16,
                        fontWeight: CustomFontWeight.medium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Units.getHeight(context: context, widgetHeight: 16),
              ),
              _buildDivider(),
              SizedBox(
                height: Units.getHeight(context: context, widgetHeight: 16),
              ),
              _buildSocialButtonsRow(),
              SizedBox(
                height: Units.getHeight(context: context, widgetHeight: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyles.textStyleBlackSB26,
        children: [
          const TextSpan(text: 'Welcome to '),
          TextSpan(
            text: 'Todyapp',
            style: TextStyle(color: ColorsManager.brandPrimarytColor),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: ColorsManager.neutralLineColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'or continue with',
            style: TextStyles.textStyleNeutralSecondaryR14,
          ),
        ),
        Expanded(child: Divider(color: ColorsManager.neutralLineColor)),
      ],
    );
  }

  Widget _buildSocialButtonsRow() {
    return Row(
      children: [
        Expanded(
          child: _socialButton(
            icon: AssetsManager.facebookIcon,
            label: 'Facebook',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _socialButton(icon: AssetsManager.googleIcon, label: 'Google'),
        ),
      ],
    );
  }

  Widget _socialButton({required String icon, required String label}) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: ColorsManager.neutralBackgroundColor,
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, width: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: ColorsManager.blackColor,
              fontWeight: CustomFontWeight.medium,
            ),
          ),
        ],
      ),
    );
  }
}
