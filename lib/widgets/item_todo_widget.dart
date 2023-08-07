import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_riverpod/models/common.dart';
import 'package:todo_app_riverpod/providers/backend_provider.dart';
import 'package:todo_app_riverpod/styles/app_style.dart';

class ItemTodoWidget extends StatelessWidget {
  final int taskNumber;
  final String taskId;
  final String title;
  final String description;
  final int category;
  final String date;
  final String time;
  final int priority;
  final bool isCompleted;
  final Function onChange;

  const ItemTodoWidget(
      {Key? key,
      required this.taskNumber,
      required this.taskId,
      required this.title,
      required this.description,
      required this.category,
      required this.date,
      required this.time,
      required this.priority,
      required this.isCompleted,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    String imageName = "medium_priority";

    switch (category) {
      case 1:
        color = Colors.green;
        break;
      case 2:
        color = Colors.blue;
        break;
      case 3:
        color = Colors.orange;
        break;
    }

    switch (priority) {
      case 0:
        imageName = "high_priority";
        break;
      case 1:
        imageName = "medium_priority";
        break;
      case 2:
        imageName = "low_priority";
        break;
    }

    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          Slidable(
            key: const ValueKey(0),
            // The start action pane is the one at the left or the top side.
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Are you sure ?"),
                          content: Text("Deleting Task: $title"),
                          actions: [
                            Consumer(
                              builder: (context, ref, child) {
                                return TextButton(
                                  onPressed: () {
                                    final stats = ref.read(statProvider);
                                    ref
                                        .read(serverProvider.notifier)
                                        .deleteTodo(taskId, isCompleted, stats);
                                    Navigator.of(context).pop();
                                    Common.showSnack(context,
                                        "Task: $title has been deleted successfully.");
                                  },
                                  child: const Text("Ok"),
                                );
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                // Close the AlertDialog and perform any additional actions here.
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel"),
                            ),
                          ],
                        );
                      },
                    ),
                  },
                  backgroundColor: Colors.red.shade500,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) => print("Edit"),
                  backgroundColor: Colors.green.shade400,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
              ],
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 5, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text("Task #$taskNumber")),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        title,
                        style: AppStyle.strikeThroughStyle(isCompleted),
                      ),
                      subtitle: Text(
                        description,
                        style: AppStyle.strikeThroughStyle(isCompleted),
                      ),
                      trailing: Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          shape: const CircleBorder(),
                          value: isCompleted,
                          activeColor: Colors.blue.shade800,
                          onChanged: (value) => onChange(value),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      color: Colors.grey.shade200,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(date),
                            const SizedBox(width: 12),
                            Text(time),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child:
                              Image.asset("assets/$imageName.png", width: 20),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
