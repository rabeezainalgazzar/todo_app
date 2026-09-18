import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/navigation/routes.dart';
import 'package:todolist/core/shared/custom_main_button.dart';
import 'package:todolist/core/style/color_manger.dart';
import 'package:todolist/core/style/text_style.dart';

import 'package:todolist/core/utils/units.dart';
import 'package:todolist/feautures/auth/auth_service.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.currentUser;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: Units.getHeight(context: context, widgetHeight: 40)),
          CircleAvatar(
            radius: 40,
            backgroundColor: ColorsManager.brandPrimaryLightColor,
            child: Icon(
              Icons.person,
              size: 40,
              color: ColorsManager.brandPrimarytColor,
            ),
          ),
          SizedBox(height: Units.getHeight(context: context, widgetHeight: 16)),
          Text(
            user?.displayName ?? 'User',
            style: TextStyles.textStyleBlackSB26.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Text(
            user?.email ?? '',
            style: TextStyles.textStyleNeutralSecondaryR14,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Units.getHeight(context: context, widgetHeight: 48)),
          CustomMainButton(
            btnTitle: 'Logout',
            onPressed: () => _onLogoutPressed(context, authService),
          ),
        ],
      ),
    );
  }

  Future<void> _onLogoutPressed(
    BuildContext context,
    AuthService authService,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await authService.signOut();
      if (context.mounted) {
        context.goNamed(Routes.kWelcomeView);
      }
    }
  }
}
