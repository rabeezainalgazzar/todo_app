import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/navigation/routes.dart';
import 'package:todolist/core/shared/custom_main_button.dart';
import 'package:todolist/core/shared/custom_text_field.dart';
import 'package:todolist/core/shared/function/show_task_sheet.dart';
import 'package:todolist/core/style/color_manger.dart';
import 'package:todolist/core/style/custom_font_weight.dart';
import 'package:todolist/core/style/text_style.dart';

import 'package:todolist/core/utils/units.dart';
import 'package:todolist/feautures/auth/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 80),
                ),
                Text(
                  'Welcome Back!',
                  style: TextStyles.textStyleBlackSB26,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 8),
                ),
                Text(
                  'Your work faster and structured with Todyapp',
                  style: TextStyles.textStyleNeutralSecondaryR14,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 48),
                ),
                Text(
                  'Email Address',
                  style: TextStyle(
                    color: ColorsManager.blackColor,
                    fontSize: 14,
                    fontWeight: CustomFontWeight.medium,
                  ),
                ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 8),
                ),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'name@example.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Email is required'
                      : null,
                ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 24),
                ),
                Text(
                  'Password',
                  style: TextStyle(
                    color: ColorsManager.blackColor,
                    fontSize: 14,
                    fontWeight: CustomFontWeight.medium,
                  ),
                ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 8),
                ),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  isPassword: true,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Password is required'
                      : null,
                ),
                const Spacer(),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomMainButton(
                        btnTitle: 'Login',
                        onPressed: _onLoginPressed,
                      ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyles.textStyleNeutralSecondaryR14,
                    ),
                    GestureDetector(
                      onTap: () => context.pushNamed(Routes.kSignupView),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: ColorsManager.brandPrimarytColor,
                          fontWeight: CustomFontWeight.medium,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 32),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onLoginPressed() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await _authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted) context.pushReplacementNamed(Routes.kHomeView);
    } catch (e) {
      if (mounted) showErrorDialog(context, _authService.mapError(e));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
