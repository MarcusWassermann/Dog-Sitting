import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dogs_sitting/gallerypage/upload_page.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:logger/logger.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final List<File> _images = [
    File('path/to/your/image1.jpg'),
    File('path/to/your/image2.jpg'),
  ]; // Beispielbilder hinzugefügt
  final logger = Logger();
  final Random _random = Random();

  // Methode zum Hochladen eines Bildes in Firebase Storage
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      margin: const EdgeInsets.all(8.0),
      height: 150,
      width: 150,
      child: Center(
        child: Text(
          'Bild ${_images.indexOf(image) + 1}',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Galerie'),
        backgroundColor: Colors.transparent, // Transparente AppBar
        elevation: 0, // Keine Schatten unter der AppBar
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
                  MaterialPageRoute(builder: (context) => const UploadPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Hintergrundbild
          Positioned.fill(
            child: Image.asset(
              'assets/3080322.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Transparenter Scaffold, damit der Hintergrund über die AppBar hinaus sichtbar ist
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  for (int i = 0; i < _images.length; i++)
                    Positioned(
                      left: _random.nextDouble() *
                          (MediaQuery.of(context).size.width - 150),
                      top: _random.nextDouble() *
                          (MediaQuery.of(context).size.height * 2 - 150),
                      child: _buildImageCard(_images[i]),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
