// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/provider/favoriten_provider.dart';
import 'package:dogs_sitting/models/user_text.dart';
import 'package:dogs_sitting/settingpage/widgets/delete_dialog.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteProvider favoriteProvider =
        Provider.of<FavoriteProvider>(context);

    final List<UserText> favorites = favoriteProvider.favorites;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/20330741.jpg',
            fit: BoxFit.cover,
          ),
          ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final UserText favorite = favorites[index];
              return FavoriteListItem(
                favorite: favorite,
              );
            },
          ),
        ],
      ),
    );
  }
}

class FavoriteListItem extends StatelessWidget {
  final UserText favorite;

  const FavoriteListItem({super.key,required this.favorite});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final bool? result = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return const DeleteDialog(action: 'Delete');
          },
        );

        if (result == true) {
          Provider.of<FavoriteProvider>(context, listen: false)
              .removeFromFavorites(favorite);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8), // Abstand um den Container herum
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white, // Weiße Füllfarbe
          border: Border.all(color: Colors.black), // Schwarzer Rand
        ),
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
                  maxLines: 3,
                  style: const TextStyle(
                      color: Colors.black), // Textfarbe anpassen
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete,
                  color: Colors.black), // Icon Farbe anpassen
              onPressed: () async {
                final bool? result = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return const DeleteDialog(action: 'Delete');
                  },
                );

                // Prüfen, ob das Widget noch im Baum vorhanden ist
                if (result == true) {
                  Provider.of<FavoriteProvider>(context, listen: false)
                      .removeFromFavorites(favorite);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
