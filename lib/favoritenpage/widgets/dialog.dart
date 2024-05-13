import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key,required this.action});

  final void Function(bool) action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Bestätigung"),
      content: const Text("Möchten Sie wirklich löschen?"),
      actions: [
        ElevatedButton(
          onPressed: () {
            action(false); // Abbrechen
            Navigator.pop(context);
          },
          child: const Text("Abbrechen"),
        ),
        ElevatedButton(
          onPressed: () {
            action(true); // Löschen
            Navigator.pop(context);
          },
          child: const Text("Löschen"),
        ),
      ],
    );
  }
}
