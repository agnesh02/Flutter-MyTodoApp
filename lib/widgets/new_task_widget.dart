import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_riverpod/models/enums.dart';
import 'package:todo_app_riverpod/models/todo.dart';
import 'package:todo_app_riverpod/providers/backend_provider.dart';
import 'package:todo_app_riverpod/providers/todo_provider.dart';
import 'package:todo_app_riverpod/styles/app_style.dart';
import 'package:todo_app_riverpod/utils/date_time_formatter.dart';
import 'package:todo_app_riverpod/widgets/date_time_widget.dart';
import 'package:todo_app_riverpod/widgets/priority_widget.dart';
import 'package:todo_app_riverpod/widgets/category_widget.dart';
import 'package:todo_app_riverpod/widgets/text_input_widget.dart';

import '../providers/new_task_provider.dart';

class NewTaskWidget extends ConsumerWidget {
  const NewTaskWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final data = ref.read(todoProvider);
    final titleTextController = TextEditingController(text: data.title);
    final descriptionTextController =
        TextEditingController(text: data.description);
    final titleTextFocusNode = FocusNode();
    final descriptionTextFocusNode = FocusNode();

    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "TODO",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Divider(
                thickness: 1.5,
                color: Colors.grey.shade200,
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  const Text('Title', style: AppStyle.textFieldHeadingStyle),
                  const SizedBox(height: 10),
                  TextInputWidget(
                    textInputController: titleTextController,
                    focusNode: titleTextFocusNode,
                    hint: "Enter task name",
                    maximumLines: 1,
                    onChangeValue: (value) {
                      ref.read(todoProvider.notifier).updateTitle(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Description',
                    style: AppStyle.textFieldHeadingStyle,
                  ),
                  const SizedBox(height: 10),
                  TextInputWidget(
                    textInputController: descriptionTextController,
                    focusNode: descriptionTextFocusNode,
                    hint: "Enter description",
                    maximumLines: 5,
                    onChangeValue: (value) {
                      ref.read(todoProvider.notifier).updateDescription(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Category',
                    style: AppStyle.textFieldHeadingStyle,
                  ),
                  SizedBox(
                    height: 80,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Center(
                            child: CategoryWidget(
                              title: 'Learn',
                              categoryColour: Colors.green,
                              valueInput: 1,
                              onChangeValue: () => ref
                                  .read(categoryProvider.notifier)
                                  .update((state) => Category.learn.value),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 150,
                          child: Center(
                            child: CategoryWidget(
                              title: 'Work',
                              categoryColour: Colors.blue,
                              valueInput: 2,
                              onChangeValue: () => ref
                                  .read(categoryProvider.notifier)
                                  .update((state) => Category.work.value),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 150,
                          child: Center(
                            child: CategoryWidget(
                              title: 'General',
                              categoryColour: Colors.orange,
                              valueInput: 3,
                              onChangeValue: () => ref
                                  .read(categoryProvider.notifier)
                                  .update((state) => Category.general.value),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Priority',
                    style: AppStyle.textFieldHeadingStyle,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        PriorityWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DateTimeWidget(
                        title: 'Date',
                        icon: const Icon(Icons.calendar_month),
                        fieldValue: date,
                        onTap: () async {
                          final dateAndTimeValue = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2024),
                          );
                          titleTextFocusNode.unfocus();
                          descriptionTextFocusNode.unfocus();
                          final date = formatSelectedDate(dateAndTimeValue!);
                          ref
                              .read(dateProvider.notifier)
                              .update((state) => date);
                        },
                      ),
                      DateTimeWidget(
                        title: 'Time',
                        icon: const Icon(Icons.access_time_sharp),
                        fieldValue: time,
                        onTap: () async {
                          final timeValue = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          final time = formatSelectedTime(timeValue!);
                          ref
                              .read(timeProvider.notifier)
                              .update((state) => time);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              side: BorderSide(color: Colors.blue.shade800),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12)),
                          onPressed: () {},
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final todoData = Todo(
                                taskId: "$date-$time",
                                taskTitle: data.title,
                                taskDescription: data.description,
                                taskCategory:
                                    ref.read(categoryProvider.notifier).state,
                                date: date,
                                time: time,
                                taskPriority:
                                    ref.read(selectedPriorityProvider),
                                isCompleted: false);

                            ref.read(serverProvider.notifier).logTodo(todoData);

                            titleTextController.clear();
                            descriptionTextController.clear();

                            ref.read(todoProvider.notifier).updateTitle("");
                            ref
                                .read(todoProvider.notifier)
                                .updateDescription("");
                            ref
                                .read(categoryProvider.notifier)
                                .update((state) => Category.general.value);
                            ref
                                .read(selectedPriorityProvider.notifier)
                                .update((state) => Priority.medium.value);
                            ref
                                .read(dateProvider.notifier)
                                .update((state) => "dd / mm / yyyy");
                            ref
                                .read(timeProvider.notifier)
                                .update((state) => "00h : 00m");
                          },
                          child: const Text("Create"),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
