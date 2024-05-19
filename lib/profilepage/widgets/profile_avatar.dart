import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 50,
          child: Icon(Icons.person),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Bild hochladen'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Bild ändern'),
              ),
            ],
            onSelected: (value) {
              if (value == 0) {
                // Handle Bild hochladen
              } else if (value == 1) {
                // Handle Bild ändern
              }
            },
          ),
        ),
      ],
    );
  }
}
