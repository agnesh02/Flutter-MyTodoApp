import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_riverpod/models/enums.dart';
import 'package:todo_app_riverpod/providers/new_task_provider.dart';

class PriorityWidget extends ConsumerWidget {
  const PriorityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selections = ref.watch(priorityProvider);
    return ToggleButtons(
      isSelected: selections,
      onPressed: (index) {
        final newSelections = List<bool>.from(selections); // [...selections];
        newSelections.asMap().forEach((key, value) {
          newSelections[key] = false;
        });
        newSelections[index] = !newSelections[index];
        ref.read(priorityProvider.notifier).update((state) => newSelections);
        var priority = -1;
        switch (index) {
          case 0:
            priority = Priority.high.value;
            break;
          case 1:
            priority = Priority.medium.value;
            break;
          case 2:
            priority = Priority.low.value;
            break;
        }

        ref.read(selectedPriorityProvider.notifier).state = priority;
        print(ref.read(selectedPriorityProvider));
        print(ref.read(priorityProvider));
      },
      children: [
        SizedBox(width: 120, child: buildPriorityItem("High", "high_priority")),
        SizedBox(
            width: 120, child: buildPriorityItem("Medium", "medium_priority")),
        SizedBox(width: 120, child: buildPriorityItem("Low", "low_priority")),
      ],
    );
  }

  static Widget buildPriorityItem(String title, String imageName) {
    return Row(
      children: [
        const SizedBox(width: 15),
        Image.asset("assets/$imageName.png", height: 30),
        const SizedBox(width: 10),
        Text(title),
      ],
    );
  }
}
