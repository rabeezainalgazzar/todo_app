import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/core/data_models/task_data_model.dart';
import 'package:todolist/core/shared/function/show_task_sheet.dart';
import 'package:todolist/core/style/color_manger.dart';
import 'package:todolist/core/style/text_style.dart';
import 'package:todolist/feautures/Home/presentation/manger/home_cubit.dart';


void showTaskDialog(
  BuildContext context, {
  required TaskModel task,
  required HomeCubit cubit,
}) {
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        task.title,
        style: TextStyles.textStyleBlackSB26.copyWith(fontSize: 20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (task.description.isNotEmpty) ...[
            Text(
              task.description,
              style: TextStyles.textStyleNeutralSecondaryR14,
            ),
            const SizedBox(height: 12),
          ],
          if (task.dueDate != null)
            Text(
              DateFormat('EEEE . dd MMM yyyy - hh:mm a').format(task.dueDate!),
              style: TextStyles.textStyleNeutralSecondaryR14,
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(dialogContext).pop();
            showTaskSheet(context, cubit: cubit, initialTask: task);
          },
          child: Text(
            'Edit',
            style: TextStyle(color: ColorsManager.brandPrimarytColor),
          ),
        ),
        TextButton(
          onPressed: () {
            if (task.id != null) cubit.deleteTask(task.id!);
            Navigator.of(dialogContext).pop();
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(
            'Close',
            style: TextStyle(color: ColorsManager.brandPrimarytColor),
          ),
        ),
      ],
    ),
  );
}
