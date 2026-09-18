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

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 60),
                ),
                Text(
                  'Create account',
                  style: TextStyles.textStyleBlackSB26,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 8),
                ),
                Text(
                  'Create your account and feel the benefits',
                  style: TextStyles.textStyleNeutralSecondaryR14,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 40),
                ),
                Text(
                  'Username',
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
                  controller: _usernameController,
                  hintText: 'Enter your username',
                  keyboardType: TextInputType.name,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Username is required'
                      : null,
                ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 24),
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
                  validator: (value) => (value == null || value.length < 6)
                      ? 'At least 6 characters'
                      : null,
                ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 32),
                ),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomMainButton(
                        btnTitle: 'Sign Up',
                        onPressed: _onSignUpPressed,
                      ),
                SizedBox(
                  height: Units.getHeight(context: context, widgetHeight: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyles.textStyleNeutralSecondaryR14,
                    ),
                    GestureDetector(
                      onTap: () => context.pushNamed(Routes.kLoginView),
                      child: Text(
                        'Login',
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

  Future<void> _onSignUpPressed() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await _authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        username: _usernameController.text.trim(),
      );

      if (mounted) context.pushReplacementNamed(Routes.kThemeView);
    } catch (e) {
      if (mounted) showErrorDialog(context, _authService.mapError(e));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
