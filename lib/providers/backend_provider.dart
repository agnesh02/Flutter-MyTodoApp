import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_riverpod/models/common.dart';
import 'package:todo_app_riverpod/models/todo.dart';
import 'package:todo_app_riverpod/utils/crud_operations.dart';

CrudOperations crudOperations = CrudOperations();

class ServerNotifier extends StateNotifier<List<Todo>> {
  ServerNotifier() : super([]);

  Future<void> fetchTodos() async {
    final todos = await crudOperations.getTodos();
    state = todos;
  }

  Future<void> logTodo(Todo todoData) async {
    await crudOperations.logTodo(Common.email, todoData);
  }

  void updateTodoStatus(String docId, int index, bool isCompleted) {
    final updatedList = [...state];
    updatedList[index].isCompleted = isCompleted;
    state = updatedList;
    updateTodoOnServer(docId, isCompleted);
  }

  Future<void> updateTodoOnServer(String docId, bool isCompleted) async {
    await crudOperations.updateCompletionStatus(
        Common.email, docId, isCompleted);
    await crudOperations.updateStat(isCompleted);
  }

  Future<void> deleteTodo(
      String docId, bool wasCompleted, Map<String, int> stats) async {
    await crudOperations.deleteTodo(docId);
    final updatedList = [...state];
    updatedList.map((item) {
      if (item.taskId == docId) {
        updatedList.remove(item);
      }
    });
    state = updatedList;
    DocumentReference docRef =
        Common.firebaseFirestoreInstance.collection(Common.email).doc("STAT");
    if (wasCompleted) {
      await docRef.update({"completed": stats["completed"]! - 1});
    } else {
      await docRef.update({"inProgress": stats["inProgress"]! - 1});
    }
  }
}

final serverProvider = StateNotifierProvider<ServerNotifier, List<Todo>>(
    (ref) => ServerNotifier());

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class StatNotifier extends StateNotifier<Map<String, int>> {
  StatNotifier() : super({"all": 0, "completed": 0, "inProgress": 0});

  void updateStats() async {
    final stats = await crudOperations.getStats();
    state = stats;
  }
}

final statProvider = StateNotifierProvider<StatNotifier, Map<String, int>>(
    (ref) => StatNotifier());
