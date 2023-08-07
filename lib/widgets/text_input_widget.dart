import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final String hint;
  final int maximumLines;
  final TextEditingController textInputController;
  final FocusNode focusNode;
  final Function(String) onChangeValue;

  const TextInputWidget({
    Key? key,
    required this.hint,
    required this.maximumLines,
    required this.textInputController,
    required this.focusNode,
    required this.onChangeValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: textInputController,
        maxLines: maximumLines,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hint,
        ),
        onChanged: (value) => onChangeValue(value),
      ),
    );
  }
}
