import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/core/data_models/task_data_model.dart';
import 'package:todolist/core/utils/firebase_service.dart';
import 'package:todolist/feautures/Home/presentation/manger/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TaskService _taskService;
  StreamSubscription<List<TaskModel>>? _tasksSubscription;

  HomeCubit(this._taskService) : super(const HomeInitial());

  void loadTasks() {
    emit(const HomeLoading());
    _tasksSubscription?.cancel();
    _tasksSubscription = _taskService.getTasks().listen(
      (tasks) => emit(HomeLoaded(tasks)),
      onError: (error) => emit(HomeError(error.toString())),
    );
  }

  Future<void> addTask(TaskModel task) async {
    await _taskService.addTask(task);
  }

  Future<void> updateTask(TaskModel task) async {
    await _taskService.updateTask(task);
  }

  Future<void> deleteTask(String id) async {
    await _taskService.deleteTask(id);
  }

  Future<void> toggleDone(TaskModel task) async {
    if (task.id == null) return;
    await _taskService.toggleDone(task.id!, !task.isDone);
  }

  @override
  Future<void> close() {
    _tasksSubscription?.cancel();
    return super.close();
  }
}
