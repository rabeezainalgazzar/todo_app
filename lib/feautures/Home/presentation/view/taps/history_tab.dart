import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/core/shared/function/show_error_dialog.dart';
import 'package:todolist/core/style/text_style.dart';
import 'package:todolist/core/utils/units.dart';
import 'package:todolist/feautures/Home/presentation/manger/home_cubit.dart';
import 'package:todolist/feautures/Home/presentation/manger/home_state.dart';
import 'package:todolist/feautures/auth/task_item.dart';


class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: Units.getHeight(context: context, widgetHeight: 16)),
          Text('History', style: TextStyles.textStyleBlackSB26),
          Text(
            'Tasks you already completed',
            style: TextStyles.textStyleNeutralSecondaryR14,
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

                final cubit = context.read<HomeCubit>();
                final completed = (state as HomeLoaded).tasks
                    .where((t) => t.isDone)
                    .toList();

                if (completed.isEmpty) {
                  return Center(
                    child: Text(
                      'No completed tasks yet',
                      style: TextStyles.textStyleNeutralSecondaryR14,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: completed.length,
                  itemBuilder: (context, index) {
                    final task = completed[index];
                    return TaskItem(
                      task: task,
                      onTap: () =>
                          showTaskDialog(context, task: task, cubit: cubit),
                      onToggleDone: (_) => cubit.toggleDone(task),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
