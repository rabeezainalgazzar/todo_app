import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/core/data_models/task_data_model.dart';

class TaskService {
  final CollectionReference<Map<String, dynamic>> _tasksRef = FirebaseFirestore
      .instance
      .collection('tasks');

  Future<void> addTask(TaskModel task) {
    return _tasksRef.add(task.toMap());
  }

  Future<void> updateTask(TaskModel task) {
    return _tasksRef.doc(task.id).update(task.toMap());
  }

  Stream<List<TaskModel>> getTasks() {
    return _tasksRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(TaskModel.fromDoc).toList());
  }

  Future<void> deleteTask(String id) {
    return _tasksRef.doc(id).delete();
  }

  Future<void> toggleDone(String id, bool isDone) {
    return _tasksRef.doc(id).update({'isDone': isDone});
  }
}
