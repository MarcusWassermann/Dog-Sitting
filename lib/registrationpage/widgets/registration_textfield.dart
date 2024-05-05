// text_field.dart
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey),
        ),
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
        ),
      ),
    );
  }
}
