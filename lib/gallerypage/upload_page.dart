// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  final double cameraPositionTop =
      100.0; //  Position der Kamera von oben festlegen
  final double textPositionTop =
      230.0; //  Position des Texts von oben festlegen
  final double buttonPositionBottom =
      300.0; //  Abstand zum unteren Rand des Bildschirms festlegen
  final double buttonWidth =
      180.0; //  Breite des Buttons festlegen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bild hochladen'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: cameraPositionTop,
            left: (MediaQuery.of(context).size.width - 100) /
                2, // Zentriert die Kamera horizontal
            child: IconButton(
              icon: const Icon(
                Icons.camera_alt,
                size: 100,
                color: Colors.blue,
              ),
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.getImage(source: ImageSource.camera);

                if (pickedFile != null) {
                  File image = File(pickedFile.path);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Bild aufgenommen: ${image.path}')),
                  );
                }
              },
            ),
          ),
          Positioned(
            top: textPositionTop,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Klicken Sie auf die Kamera, um ein Foto aufzunehmen',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: buttonPositionBottom,
            left: (MediaQuery.of(context).size.width - buttonWidth) /
                2, // Zentriert den Button horizontal
            child: ElevatedButton.icon(
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.getImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  File image = File(pickedFile.path);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Bild ausgewählt: ${image.path}')),
                  );
                }
              },
              icon: const Icon(Icons.photo),
              label: const Text('Bild hochladen'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
