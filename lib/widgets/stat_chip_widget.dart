import 'package:flutter/material.dart';

class StatChipWidget extends StatelessWidget {
  final String title;
  final int value;
  final Color color;

  const StatChipWidget(
      {super.key,
      required this.title,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Text(title),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color,
            ),
            child: Text(
              value.toString(), // Replace this with your desired number
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white), // Adjust font size as needed
            ),
          ),
        ],
      ),
    );
  }
}
