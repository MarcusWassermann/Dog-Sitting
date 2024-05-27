import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String action;
  final Function onDelete;

  const DeleteDialog({
    super.key,
    required this.action,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Bestätigung"),
      content: Text("Möchten Sie $action wirklich löschen?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Abbrechen"),
        ),
        TextButton(
          onPressed: () {
            onDelete();
            Navigator.pop(
                context); // Sicherstellen, dass der Dialog nach der Aktion geschlossen wird
          },
          child: const Text("Löschen"),
        ),
      ],
    );
  }
}
