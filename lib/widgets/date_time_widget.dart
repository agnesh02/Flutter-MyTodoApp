import 'package:flutter/material.dart';
import 'package:todo_app_riverpod/styles/app_style.dart';

class DateTimeWidget extends StatelessWidget {
  final String title, fieldValue;
  final Icon icon;
  final VoidCallback onTap;

  const DateTimeWidget(
      {Key? key,
      required this.title,
      required this.fieldValue,
      required this.icon,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppStyle.textFieldHeadingStyle),
        const SizedBox(height: 10),
        InkWell(
          onTap: () => onTap(),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                icon,
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(fieldValue),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
