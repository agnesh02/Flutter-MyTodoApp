import 'package:flutter/material.dart';

class FieldInputWidget extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final Color borderColor;
  final Function(String) onChange;

  const FieldInputWidget(
      {super.key,
      required this.hint,
      required this.textEditingController,
      required this.borderColor,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: [
          Container(
            width: 300,
            height: 50,
            decoration: ShapeDecoration(
              color: const Color(0x33C4C4C4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: borderColor, // Border color
                  width: 2, // Border width
                ),
              ),
            ),
            child: TextFormField(
              onChanged: (val) => onChange(val),
              controller: textEditingController,
              decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorBorder: InputBorder.none),
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
