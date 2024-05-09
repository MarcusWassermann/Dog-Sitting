import 'package:dogs_sitting/models/user_text.dart';
import 'package:dogs_sitting/provider/favoriten_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteProvider favoriteProvider =
        Provider.of<FavoriteProvider>(context);

    final List<UserText> favorites = favoriteProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final UserText favorite = favorites[index];
          return FavoriteListItem(
              favorite:
                  favorite); // Verwende den Container für das favorisierte Element
        },
      ),
    );
  }
}

class FavoriteListItem extends StatelessWidget {
  final UserText favorite;

  const FavoriteListItem({super.key,required this.favorite});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 80,
            height: 80,
            color: Colors.blue,
            child: favorite.imagePath != null
                ? Image.asset(favorite.imagePath!, fit: BoxFit.cover)
                : null,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                favorite.text,
                overflow: TextOverflow.ellipsis,
                maxLines: 3, // Zeige maximal 3 Zeilen Text an
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              Provider.of<FavoriteProvider>(context, listen: false)
                  .removeFromFavorites(favorite);
            },
          ),
        ],
      ),
    );
  }
}
