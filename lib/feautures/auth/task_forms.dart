import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todolist/core/data_models/task_data_model.dart';
import 'package:todolist/core/style/assets_manger.dart';
import 'package:todolist/core/style/color_manger.dart';

class TaskForm extends StatefulWidget {
  final TaskModel? initialTask;
  final void Function(TaskModel task) onSubmit;

  const TaskForm({super.key, this.initialTask, required this.onSubmit});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  DateTime? _dueDate;
  TimeOfDay? _dueTime;
  TaskPriority _priority = TaskPriority.low;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialTask;
    _titleController = TextEditingController(text: initial?.title ?? '');
    _descriptionController = TextEditingController(
      text: initial?.description ?? '',
    );
    _priority = initial?.priority ?? TaskPriority.low;
    _dueDate = initial?.dueDate;
    if (initial?.dueDate != null) {
      _dueTime = TimeOfDay.fromDateTime(initial!.dueDate!);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 12),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: ColorsManager.brandPrimarytColor,
                width: 3,
              ),
            ),
          ),
          child: TextField(
            controller: _titleController,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              hintText: 'eg : Meeting with client',
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _descriptionController,
          maxLines: 2,
          style: TextStyle(color: ColorsManager.neutralSecondaryColor),
          decoration: const InputDecoration(
            hintText: 'Description',
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _iconButton(AssetsManager.inboxIcon, active: false, onTap: () {}),
            _iconButton(
              AssetsManager.calendarIcon,
              active: _dueDate != null,
              onTap: _pickDate,
            ),
            _iconButton(
              AssetsManager.clockIcon,
              active: _dueTime != null,
              onTap: _pickTime,
            ),
            _iconButton(
              AssetsManager.flagIcon,
              active: _priority != TaskPriority.low,
              tint: _priorityColor(),
              onTap: _cyclePriority,
            ),
            const Spacer(),
            IconButton(
              onPressed: _submit,
              icon: SvgPicture.asset(
                AssetsManager.sendIcon,
                width: 22,
                colorFilter: ColorFilter.mode(
                  ColorsManager.brandPrimarytColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _iconButton(
    String icon, {
    required bool active,
    Color? tint,
    required VoidCallback onTap,
  }) {
    final color =
        tint ??
        (active
            ? ColorsManager.brandPrimarytColor
            : ColorsManager.neutralSecondaryColor);
    return IconButton(
      onPressed: onTap,
      icon: SvgPicture.asset(
        icon,
        width: 20,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }

  Color _priorityColor() {
    switch (_priority) {
      case TaskPriority.low:
        return ColorsManager.neutralSecondaryColor;
      case TaskPriority.medium:
        return const Color(0xffF5A623);
      case TaskPriority.high:
        return const Color(0xffEF5350);
    }
  }

  void _cyclePriority() {
    setState(() {
      _priority = switch (_priority) {
        TaskPriority.low => TaskPriority.medium,
        TaskPriority.medium => TaskPriority.high,
        TaskPriority.high => TaskPriority.low,
      };
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _dueTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _dueTime = picked);
  }

  void _submit() {
    if (_titleController.text.trim().isEmpty) return;

    DateTime? combinedDueDate = _dueDate;
    if (_dueDate != null && _dueTime != null) {
      combinedDueDate = DateTime(
        _dueDate!.year,
        _dueDate!.month,
        _dueDate!.day,
        _dueTime!.hour,
        _dueTime!.minute,
      );
    }

    final task = TaskModel(
      id: widget.initialTask?.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      dueDate: combinedDueDate,
      priority: _priority,
      isDone: widget.initialTask?.isDone ?? false,
      createdAt: widget.initialTask?.createdAt,
    );

    widget.onSubmit(task);
  }
}
