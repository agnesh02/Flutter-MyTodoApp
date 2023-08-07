import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_riverpod/models/common.dart';
import 'package:todo_app_riverpod/providers/backend_provider.dart';
import 'package:todo_app_riverpod/screens/login_screen.dart';
import 'package:todo_app_riverpod/widgets/item_todo_widget.dart';
import 'package:todo_app_riverpod/widgets/new_task_widget.dart';

import '../widgets/stat_chip_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(serverProvider);
    final statItem = ref.watch(statProvider);

    final DateTime now = DateTime.now();
    final String currentDay = DateFormat('EEEE, d MMM').format(now);

    print("in");

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade200,
            radius: 25,
            child: Image.asset("assets/user.png"),
          ),
          title: Text(
            "Hello,",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
          subtitle: Text(
            Common.username,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    ref.read(serverProvider.notifier).fetchTodos();
                    ref.read(statProvider.notifier).updateStats();
                    // print(ref.read(serverProvider.notifier).state.toString());
                  },
                  icon: const Icon(Icons.notifications_active_outlined)),
              IconButton(
                  onPressed: () {
                    Common.firebaseAuthInstance.signOut();
                    Common.navigateTo(context, LoginScreen());
                  },
                  icon: const Icon(Icons.logout)),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's Task",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      " $currentDay",
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    context: context,
                    builder: (context) => const NewTaskWidget(),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD5E8FA),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "+ New task",
                    style: TextStyle(color: Colors.blue.shade700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatChipWidget(
                    title: "All",
                    value: statItem["all"]!,
                    color: Colors.blue.shade500,
                  ),
                  StatChipWidget(
                    title: "Completed",
                    value: statItem["completed"]!,
                    color: Colors.green.shade500,
                  ),
                  StatChipWidget(
                    title: "In Progress",
                    value: statItem["inProgress"]!,
                    color: Colors.orange.shade600,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  ref.read(statProvider.notifier).updateStats();
                  return ref.refresh(serverProvider.notifier).fetchTodos();
                },
                child: item.isEmpty
                    ? ListView(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Center(
                              child: Text(
                                "Start adding tasks !!",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ItemTodoWidget(
                                taskNumber: index + 1,
                                taskId: item[index].taskId,
                                title: item[index].taskTitle,
                                description: item[index].taskDescription,
                                category: item[index].taskCategory,
                                date: item[index].date,
                                time: item[index].time,
                                priority: item[index].taskPriority,
                                isCompleted: item[index].isCompleted,
                                onChange: (val) {
                                  final isCompleted = !item[index].isCompleted;
                                  ref
                                      .read(serverProvider.notifier)
                                      .updateTodoStatus(
                                        item[index].taskId,
                                        index,
                                        isCompleted,
                                      );
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
