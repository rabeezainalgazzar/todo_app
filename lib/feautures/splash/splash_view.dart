import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/navigation/routes.dart';
import 'package:todolist/core/shared/app_logo.dart';
import 'package:todolist/core/style/color_manger.dart';
import 'package:todolist/core/style/text_style.dart';
import 'package:todolist/feautures/auth/auth_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    routeNext();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      body: Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(),
            Text(
              'The best to do list application for you',
              style: TextStyles.textStyleBrandPrimaryLightColorM18,
            ), // Text
          ],
        ), // Column
      ), // Center
    ); // Scaffold
  }

  void routeNext() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      final isLoggedIn = AuthService().currentUser != null;
      if (isLoggedIn) {
        context.pushReplacementNamed(Routes.kHomeView);
      } else {
        context.pushReplacementNamed(Routes.kOnboardingView);
      }
    }); // Future.delayed
  }
}
