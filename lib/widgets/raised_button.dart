import 'package:flutter/material.dart';

class RaisedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const RaisedButtonWidget(
      {super.key,  required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
