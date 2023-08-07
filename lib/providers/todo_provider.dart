import 'package:flutter_riverpod/flutter_riverpod.dart';

class Task {
  final String title;
  final String description;

  Task({required this.title, required this.description});
}

class TodoNotifier extends StateNotifier<Task> {
  TodoNotifier() : super(Task(title: "", description: ""));

  void updateTitle(String titleText) {
    state = Task(title: titleText, description: state.description);
  }

  void updateDescription(String descriptionText) {
    state = Task(title: state.title, description: descriptionText);
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, Task>(
  (ref) => TodoNotifier(),
);