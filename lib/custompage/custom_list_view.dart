import 'package:flutter/material.dart';
import 'package:flutter_dog/provider/favoriten_provider.dart';
import 'package:provider/provider.dart';

class CustomListViewScreen extends StatelessWidget {
  const CustomListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = List.generate(20, (index) => 'Item $index');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom ListView'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          if (index < items.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomListItem(index: index),
            );
          } else {
            return Container(); // Rückgabe einer leeren Container, wenn der Index außerhalb des gültigen Bereichs liegt
          }
        },
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  final int index;

  const CustomListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Höhe des Listenelements
      color: Colors.grey[300], // Hintergrundfarbe des Listenelements
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // Hier wird der Container dupliziert und zum Favoriten hinzugefügt
                final item = 'Item $index';
                final isFavorite =
                    Provider.of<FavoriteProvider>(context, listen: false)
                        .favorites
                        .contains(item);
                if (isFavorite) {
                  Provider.of<FavoriteProvider>(context, listen: false)
                      .removeFromFavorites(item);
                } else {
                  Provider.of<FavoriteProvider>(context, listen: false)
                      .addToFavorites(item);
                }
              },
              child: Consumer<FavoriteProvider>(
                builder: (context, favoriteProvider, child) {
                  final isFavorite =
                      favoriteProvider.favorites.contains('Item $index');
                  return Container(
                    width: 80, // Breite des Bildcontainers
                    height: 80, // Höhe des Bildcontainers
                    color: Colors.blue, // Hintergrundfarbe des Bildcontainers
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_outline,
                      color: isFavorite ? Colors.red : Colors.white,
                    ), // Beispiel: Ein Herz-Icon
                  );
                },
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Geben Sie Ihren Text hier ein', // Platzhaltertext
                  border: OutlineInputBorder(), // Stil der Textfeldgrenze
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
