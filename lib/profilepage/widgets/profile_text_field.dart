import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final double width;
  final double height;
  final TextInputType keyboardType;
  final bool optional;
  final Color? fillColor;

  const ProfileTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.width = 200.0,
    this.height = 40.0,
    this.keyboardType = TextInputType.text,
    this.optional = false,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          suffixText: optional ? ' (Optional)' : '',
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          filled: true,
          fillColor: fillColor ?? Colors.transparent,
        ),
      ),
    );
  }
}
