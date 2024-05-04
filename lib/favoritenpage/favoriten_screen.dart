import 'package:flutter/material.dart';
import 'package:flutter_dog/provider/favoriten_provider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  final List<String> favorites;

  const FavoriteScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favorites[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // Entferne das Element aus der Favoritenliste
                Provider.of<FavoriteProvider>(context, listen: false)
                    .removeFromFavorites(favorites[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
