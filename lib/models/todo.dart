import 'package:todo_app_riverpod/models/enums.dart';

class Todo {
  final String taskId;
  final String taskTitle;
  final String taskDescription;
  final int taskCategory;
  final String date;
  final String time;
  final int taskPriority;
  bool isCompleted;

  Todo(
      {required this.taskId,
      required this.taskTitle,
      required this.taskDescription,
      required this.taskCategory,
      required this.date,
      required this.time,
      required this.taskPriority,
      required this.isCompleted});

  @override
  String toString() {
    return "Title: $taskTitle\nDesc: $taskDescription\nCategory: ${Category.values[taskCategory - 1]}\nDate: $date\nTime: $time\nPriority ${Priority.values[taskPriority]}\nisCompleted: $isCompleted";
  }
}
