import 'package:dogs_sitting/favoritenpage/repositorys/favorite_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteRepository = Provider.of<FavoriteRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: StreamBuilder<List<String>>(
        stream: favoriteRepository.getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final favorites = snapshot.data;
          if (favorites == null || favorites.isEmpty) {
            return const Center(child: Text('No favorites yet!'));
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              return ListTile(
                title: Text(favorite),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Hier sollte die Methode zum Entfernen des Favoriten aus dem Repository aufgerufen werden
                    // favoriteRepository.removeFavorite(...);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
