import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const CustomTextField({super.key, 
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
          errorStyle: const TextStyle(
            color: Colors.red, // Fehlermeldung in Rot einfärben
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black, // Fokussierter Rahmen in Schwarz
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: errorText != null
                  ? Colors.red
                  : Colors
                      .black, // Rahmen in Rot einfärben, wenn Fehlermeldung vorhanden ist
            ),
          ),
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
      ),
    );
  }
}
