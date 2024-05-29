// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dogs_sitting/gallerypage/upload_page.dart';
import 'package:logger/logger.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final List<File> _images = []; // Liste für hochgeladene Bilder
  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    const int gridCount = 3; // Anzahl der Spalten im Raster

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Galerie'),
        backgroundColor: Colors.transparent, // Transparente AppBar
        elevation: 0, // Kein Schatten unter der AppBar
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
                ).then((uploadedImage) {
                  if (uploadedImage != null) {
                    setState(() {
                      _images.add(uploadedImage);
                    });
                  }
                });
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
          // Raster von Bildcontainern
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCount,
              childAspectRatio: 1, // Quadratische Container
            ),
            itemCount: _images.length + gridCount, // Anzahl der Container
            itemBuilder: (context, index) {
              if (index < _images.length) {
                return _buildImageCard(_images[index]);
              } else {
                // Erster Container bleibt unverändert
                if (index == gridCount) {
                  return _buildEmptyImageCard();
                }
                // Mittlerer Container wird links geneigt
                else if (index == gridCount + 1) {
                  return Transform.rotate(
                    angle: -0.9, // Linksneigung um 0.1 Radiant
                    child: _buildEmptyImageCard(),
                  );
                }
                // Letzter Container wird rechts geneigt
                else {
                  return Transform.rotate(
                    angle: 0.3, // Rechtsneigung um 0.1 Radiant
                    child: _buildEmptyImageCard(),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
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
      child: Image.file(image, fit: BoxFit.cover),
    );
  }

  // Widget zum Aufbau eines leeren Bildcontainers
  Widget _buildEmptyImageCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300], // Grauer Hintergrund für leere Container
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      margin: const EdgeInsets.all(8.0),
    );
  }
}
