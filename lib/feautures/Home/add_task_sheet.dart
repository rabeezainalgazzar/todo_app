import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todolist/core/data_models/task_data_model.dart';
import 'package:todolist/core/style/assets_manger.dart';
import 'package:todolist/core/style/color_manger.dart';
import 'package:todolist/core/utils/firebase_service.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _taskService = TaskService();

  DateTime? _dueDate;
  TimeOfDay? _dueTime;
  TaskPriority _priority = TaskPriority.low;
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
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
              _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : IconButton(
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
      ),
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

  Future<void> _submit() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }

    setState(() => _isSaving = true);

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
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      dueDate: combinedDueDate,
      priority: _priority,
    );

    try {
      await _taskService.addTask(task);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to save task: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
