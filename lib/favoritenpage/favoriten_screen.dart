import 'package:flutter/material.dart';
import 'package:flutter_dog/provider/favoriten_provider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoriten'),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, _) {
          if (provider.favorites.isEmpty) {
            return const Center(
              child: Text('Keine Favoriten vorhanden'),
            );
          } else {
            return ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100, // Höhe des Listenelements
                    color:
                        Colors.grey[300], // Hintergrundfarbe des Listenelements
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 80, // Breite des Bildcontainers
                            height: 80, // Höhe des Bildcontainers
                            color: Colors
                                .blue, // Hintergrundfarbe des Bildcontainers
                            // Fügen Sie hier Ihr Bild hinzu oder andere Inhalte, die Sie anzeigen möchten
                            child: const Icon(Icons.image,
                                color: Colors.white), // Beispiel: Ein Bild-Icon
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText:
                                    'Geben Sie Ihren Text hier ein', // Platzhaltertext
                                border:
                                    OutlineInputBorder(), // Stil der Textfeldgrenze
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
