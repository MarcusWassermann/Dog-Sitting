

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed; // onPressed kann null sein
  final String text; // Definieren Sie den Parameter text

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text, // Fügen Sie den Parameter text hinzu
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onPressed, // onPressed kann null sein
        child: Text(
          text, // Verwenden Sie den Parameter text
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
