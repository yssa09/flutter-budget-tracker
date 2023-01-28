import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboard;

  CustomTextField({
    required this.hint,
    required this.label,
    required this.controller,
    this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        controller: controller,
        keyboardType: keyboard,
      ),
    );
  }
}

class CustomTotalWidget extends StatelessWidget {
  String text;
  String amount;
  Color? color;

  CustomTotalWidget({required this.text, required this.amount, this.color});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Text(text),
          Text(
            amount,
            style: TextStyle(
                fontSize: 18, color: color, overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}
