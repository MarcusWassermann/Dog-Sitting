import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/provider/user_text_provider.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key, required String action});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirmation"),
      content: const Text("Are you sure you want to delete all user texts?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Provider.of<UserTextProvider>(context, listen: false)
                .deleteAllUserTexts();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('User texts deleted'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Implement the undo action here
                  },
                ),
              ),
            );
            Navigator.pop(context);
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
