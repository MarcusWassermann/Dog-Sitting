// ignore_for_file: use_build_context_synchronously, deprecated_member_use, library_private_types_in_public_api, unused_element

import 'dart:io';
import 'package:dogs_sitting/gallerypage/upload_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart'
    as firebase_storage; // Import für firebase_storage hinzugefügt
import 'package:logger/logger.dart'; // Logger-Bibliothek importiert

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final List<File> _images = [];
  final logger = Logger(); // Logger-Instanz erstellt

  // Methode zum Hochladen eines Bildes
  Future<void> _uploadImage(File image) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      firebase_storage.UploadTask uploadTask = ref.putFile(image);
      await uploadTask.whenComplete(() => logger.d('Bild hochgeladen'));
    } catch (e) {
      logger.e('Fehler beim Hochladen des Bildes: $e');
    }
  }

  // Widget zum Aufbau einer Bildkarte
  Widget _buildImageCard(File image) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.file(
            image,
            fit: BoxFit.cover,
            height: 150.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Bild ${_images.indexOf(image) + 1}',
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Image uploader',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add_photo_alternate),
              title: const Text('Bild hochladen'),
              onTap: () {
                Navigator.pop(context); // Schließt den Drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UploadPage()));
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: _images.map((image) => _buildImageCard(image)).toList(),
      ),
    );
  }
}
