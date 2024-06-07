// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dogs_sitting/gallerypage/upload_page.dart';
import 'package:logger/logger.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final List<File> _images = [];
  final logger = Logger();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Galerie'),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                'Bild hochladen',
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
                Navigator.pop(context);
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
          Positioned.fill(
            child: Image.asset(
              'assets/15.png',
              fit: BoxFit.cover,
            ),
          ),
          ...List.generate(
            _images.length,
            (index) {
              // Zufällige Position innerhalb des sichtbaren Bereichs des Bildschirms
              double left = Random().nextDouble() *
                  (MediaQuery.of(context).size.width -
                      100); // 100 ist die Breite des Containers
              double top = Random().nextDouble() *
                  (MediaQuery.of(context).size.height -
                      100); // 100 ist die Höhe des Containers

              return Positioned(
                left: left,
                top: top,
                child: _buildImageCard(_images[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(File image) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: Image.file(image, fit: BoxFit.cover),
    );
  }
}
