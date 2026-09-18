import 'package:todolist/core/data_models/task_data_model.dart';


sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<TaskModel> tasks;
  const HomeLoaded(this.tasks);
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}
