import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/new_task_provider.dart';

class CategoryWidget extends ConsumerWidget {
  final String title;
  final Color? categoryColour;
  final int valueInput;
  final VoidCallback onChangeValue;

  const CategoryWidget({
    Key? key,
    required this.title,
    required this.categoryColour,
    required this.valueInput,
    required this.onChangeValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radio = ref.watch(categoryProvider);

    return Material(
      child: Theme(
        data: ThemeData(unselectedWidgetColor: categoryColour),
        child: RadioListTile(
          activeColor: categoryColour,
          title: Transform.translate(
            offset: const Offset(-22, 0),
            child: Text(
              title,
              style: TextStyle(
                color: categoryColour,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          value: valueInput,
          groupValue: radio,
          onChanged: (value) => onChangeValue(),
        ),
      ),
    );
  }
}
