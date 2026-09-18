import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/core/shared/function/show_task_sheet.dart';
import 'package:todolist/core/style/color_manger.dart';
import 'package:todolist/core/utils/firebase_service.dart';

import 'package:todolist/feautures/Home/home_bottom_nav_bar.dart';
import 'package:todolist/feautures/Home/presentation/manger/home_cubit.dart';
import 'package:todolist/feautures/Home/presentation/view/taps/calender_tab.dart';
import 'package:todolist/feautures/Home/presentation/view/taps/history_tab.dart';
import 'package:todolist/feautures/Home/presentation/view/taps/home_tab.dart';
import 'package:todolist/feautures/Home/presentation/view/taps/profile_tab.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(TaskService())..loadTasks(),
      child: const _HomeShell(),
    );
  }
}

class _HomeShell extends StatefulWidget {
  const _HomeShell();

  @override
  State<_HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<_HomeShell> {
  int _currentTab = 0;

  static const List<Widget> _tabs = [
    HomeTab(),
    CalendarTab(),
    HistoryTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _currentTab,
        onTap: (index) => setState(() => _currentTab = index),
      ),

      floatingActionButton: (_currentTab == 0)
          ? FloatingActionButton(
              backgroundColor: ColorsManager.brandPrimarytColor,
              onPressed: () =>
                  showTaskSheet(context, cubit: context.read<HomeCubit>()),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: SafeArea(
        child: IndexedStack(index: _currentTab, children: _tabs),
      ),
    );
  }
}
