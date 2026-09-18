import 'package:flutter/material.dart';
import 'package:todolist/core/data_models/task_data_model.dart';
import 'package:todolist/core/style/color_manger.dart';
import 'package:todolist/core/style/text_style.dart';


class TaskItem extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;
  final ValueChanged<bool?> onToggleDone;

  const TaskItem({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggleDone,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: ColorsManager.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border(left: BorderSide(color: _priorityColor(), width: 4)),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.neutralLineColor.withAlpha(100),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Checkbox(
              value: task.isDone,
              activeColor: ColorsManager.brandPrimarytColor,
              onChanged: onToggleDone,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : null,
                      color: task.isDone
                          ? ColorsManager.neutralSecondaryColor
                          : ColorsManager.blackColor,
                    ),
                  ),
                  if (task.description.isNotEmpty)
                    Text(
                      task.description,
                      style: TextStyles.textStyleNeutralSecondaryR14,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            if (task.dueDate != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  TimeOfDay.fromDateTime(task.dueDate!).format(context),
                  style: TextStyles.textStyleNeutralSecondaryR14,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _priorityColor() {
    switch (task.priority) {
      case TaskPriority.low:
        return ColorsManager.neutralLineColor;
      case TaskPriority.medium:
        return const Color(0xffF5A623);
      case TaskPriority.high:
        return const Color(0xffEF5350);
    }
  }
}
