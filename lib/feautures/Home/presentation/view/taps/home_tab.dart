import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todolist/core/data_models/task_data_model.dart';
import 'package:todolist/core/shared/function/show_error_dialog.dart';
import 'package:todolist/core/style/color_manger.dart';
import 'package:todolist/core/style/text_style.dart';
import 'package:todolist/core/utils/units.dart';
import 'package:todolist/feautures/Home/presentation/manger/home_cubit.dart';
import 'package:todolist/feautures/Home/presentation/manger/home_state.dart';
import 'package:todolist/feautures/auth/task_item.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: Units.getHeight(context: context, widgetHeight: 16)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Today', style: TextStyles.textStyleBlackSB26),
                    Text(
                      'Best platform for creating to-do lists',
                      style: TextStyles.textStyleNeutralSecondaryR14,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.settings_outlined,
                color: ColorsManager.neutralSecondaryColor,
              ),
            ],
          ),
          SizedBox(height: Units.getHeight(context: context, widgetHeight: 20)),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading || state is HomeInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is HomeError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyles.textStyleNeutralSecondaryR14,
                    ),
                  );
                }

                final tasks = (state as HomeLoaded).tasks;
                if (tasks.isEmpty) return _buildEmptyState(context);

                final grouped = _groupByDate(tasks);
                final cubit = context.read<HomeCubit>();

                return ListView(
                  children: grouped.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: TextStyles.textStyleNeutralSecondaryR14,
                          ),
                          const SizedBox(height: 8),
                          ...entry.value.map(
                            (task) => TaskItem(
                              task: task,
                              onTap: () => showTaskDialog(
                                context,
                                task: task,
                                cubit: cubit,
                              ),
                              onToggleDone: (_) => cubit.toggleDone(task),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<TaskModel>> _groupByDate(List<TaskModel> tasks) {
    final Map<String, List<TaskModel>> grouped = {};
    for (final task in tasks) {
      final date = task.dueDate ?? task.createdAt;
      final label = DateFormat('EEEE . dd MMM yyyy').format(date);
      grouped.putIfAbsent(label, () => []).add(task);
    }
    return grouped;
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: Units.getHeight(context: context, widgetHeight: 8),
          decoration: BoxDecoration(
            color: ColorsManager.brandPrimarytColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorsManager.whiteColor,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(14),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: ColorsManager.brandPrimarytColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Tap the + button to create a new task',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
