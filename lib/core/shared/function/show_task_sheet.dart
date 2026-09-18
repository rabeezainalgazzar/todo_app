import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todolist/core/data_models/task_data_model.dart';

import 'package:todolist/core/style/assets_manger.dart';
import 'package:todolist/core/style/color_manger.dart';
import 'package:todolist/feautures/Home/presentation/manger/home_cubit.dart';
import 'package:todolist/feautures/auth/task_forms.dart';

void showTaskSheet(
  BuildContext context, {
  required HomeCubit cubit,
  TaskModel? initialTask,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: ColorsManager.whiteColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
      ),
      child: TaskForm(
        initialTask: initialTask,
        onSubmit: (task) async {
          try {
            if (task.id != null) {
              await cubit.updateTask(task);
            } else {
              await cubit.addTask(task);
            }
            if (sheetContext.mounted) {
              Navigator.of(sheetContext).pop();
              _showSuccessFlash(context);
            }
          } catch (e) {
            if (sheetContext.mounted) {
              Navigator.of(sheetContext).pop();
              showErrorDialog(
                context,
                'Failed to save task, please try again.',
              );
            }
          }
        },
      ),
    ),
  );
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showSuccessFlash(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (dialogContext.mounted) Navigator.of(dialogContext).pop();
      });
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Lottie.asset(
          AssetsManager.successLottie,
          width: 140,
          height: 140,
          repeat: false,
        ),
      );
    },
  );
}
